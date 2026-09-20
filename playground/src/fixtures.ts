/** Read the current numbered catalogue, with legacy discovery for older clones. */
import { readdir, readFile, stat } from 'node:fs/promises';
import path from 'node:path';

export interface Binding {
	name: string;
	fixture?: string;
	content?: string;
	format?: string;
	/**
	 * `-li`, a literal with no MIME type at all. Not the same as inline content
	 * in some format: one chapter turns on the difference, because a literal
	 * without an `input` directive is exactly what the engine refuses.
	 */
	literal?: boolean;
}

/** Inputs, parameters and module paths used for the recorded result. */
export interface Bindings {
	inputs: Binding[];
	params: Array<{ name: string; value: string }>;
	modulePaths: string[];
}

export interface Example {
	/** Catalogue identity; the human-readable name is a separate label. */
	id: string;
	chapter: string;
	name: string;
	label?: string;
	script: string;
	/** Repo-relative path of the saved output, when the chapter kept one. */
	savedOutput?: string;
	/**
	 * What to bind when this example is opened. Without it the page has to guess,
	 * and guessing was wrong for 72 of the 137 examples: it bound the chapter's
	 * first JSON file to `payload` whatever the example actually read, so every
	 * XML and CSV example, every example that reads nothing, the one with an
	 * inline input and the one that takes params all ran against the wrong thing
	 * and reported Differs against a book they had never been compared with.
	 */
	bindings?: Bindings;
}

export interface Chapter {
	id: string;
	examples: Example[];
	inputs: string[];
}

const INPUT_EXT = new Set(['.json', '.xml', '.csv', '.yaml', '.yml', '.txt', '.properties', '.ffd']);

const splitOnce = (s: string): [string, string] => {
	const at = s.indexOf('=');
	return [s.slice(0, at), s.slice(at + 1)];
};

/** The CLI's own flags, read back off a command line. */
function parseArgs(command: string): Bindings {
	const args = command.match(/'[^']*'|"[^"]*"|\S+/g) ?? [];
	const inputs: Binding[] = [];
	const params: Array<{ name: string; value: string }> = [];
	const modulePaths: string[] = [];
	for (let i = 0; i < args.length; i++) {
		const flag = args[i];
		const value = (args[i + 1] ?? '').replace(/^['"]|['"]$/g, '');
		if (flag === '-i') {
			const [n, file] = splitOnce(value);
			inputs.push({ name: n, fixture: file });
			i++;
		} else if (flag === '-li') {
			const [n, content] = splitOnce(value);
			inputs.push({ name: n, content, literal: true });
			i++;
		} else if (flag === '-p') {
			const [n, v] = splitOnce(value);
			params.push({ name: n, value: v });
			i++;
		} else if (flag.startsWith('--path=')) {
			modulePaths.push(...flag.slice('--path='.length).split(':').filter(Boolean));
		} else if (flag === '--path') {
			modulePaths.push(...value.split(':').filter(Boolean));
			i++;
		}
	}
	return { inputs, params, modulePaths };
}

/**
 * The other half of the catalogue.
 *
 * Eleven of the sixteen chapters do not use `go` lines: their run.sh loops over
 * every `.dwl` in the folder and writes the exact command it ran as the first
 * line of the `.out`. That header is the binding source for those 393 examples
 * — and, until it was stripped, the reason none of the 117 that carry one could
 * ever match, because the saved file held a command line that no run produces.
 */
const SAVED_HEADER = /^\$ dw [^\n]*\n/;
function parseSavedHeader(saved: string): Bindings | null {
	const m = saved.match(SAVED_HEADER);
	if (!m || !/^\$ dw run\b/.test(m[0])) return null;
	return parseArgs(m[0].replace(/^\$ dw run\b/, ''));
}

/**
 * Pull the `go <name> [args]` lines out of a chapter's run.sh — the script that
 * produced every `.out` file beside it — and read the bindings back off them.
 *
 * Two things this has to get right, both of which were got wrong once:
 * run.sh defines its fixtures on ONE line (`J="…"; X="…"; CSV="…"`), so the
 * match must not anchor to the start of a line or only the first is ever found
 * and the XML and CSV examples silently run with no input. And `J="-i
 * payload=$C/order.json"` nests one variable inside another, so expansion
 * repeats until it settles rather than running once.
 */
function parseRunScript(source: string, chapter: string, dwlNames: string[]): Map<string, Bindings> {
	const vars: Record<string, string> = { C: `chapters/${chapter}` };
	for (const m of source.matchAll(/\b([A-Z][A-Z0-9_]*)="([^"]*)"/g)) vars[m[1]] = m[2];
	const expand = (s: string): string => {
		let out = s;
		for (let i = 0; i < 5 && /\$[A-Za-z_]/.test(out); i++) {
			out = out.replace(/\$([A-Za-z_]+)/g, (_, n: string) => vars[n] ?? '');
		}
		return out;
	};

	const found = new Map<string, Bindings>();
	for (const line of source.split('\n')) {
		const m = line.match(/^go\s+(\S+)\s*(.*)$/);
		if (!m) continue;
		const [, name, rest] = m;
		found.set(name, parseArgs(expand(rest)));
	}

	// Two chapters call the same `go` from a loop instead of listing the calls —
	// `for n in 01_named_fun 02_… ; do go $n $J; done`, or the same with
	// `$(ls [0-9]*.dwl)` in place of the list. Same bindings for every probe.
	for (const m of source.matchAll(/for\s+(\w+)\s+in\s+([\s\S]*?)\s*;\s*do\s*\n?\s*go\s+\$\1\s*([^\n;]*)/g)) {
		const [, , list, rest] = m;
		const names = list.includes('$(ls') ? dwlNames : list.trim().split(/\s+/).filter(Boolean);
		const args = parseArgs(expand(rest));
		for (const name of names) if (!found.has(name)) found.set(name, args);
	}
	return found;
}

/**
 * The fourth shape: four chapters drive `run-chapter.sh` from a `manifest`,
 * one probe per line — `<probe.dwl> <input|-> [extra dw args]`, paths relative
 * to the folder, and `@` standing for the chapter directory.
 */
function parseManifest(source: string, chapter: string): Map<string, Bindings> {
	const found = new Map<string, Bindings>();
	const rel = `chapters/${chapter}`;
	for (const line of source.split('\n')) {
		const trimmed = line.trim();
		if (!trimmed || trimmed.startsWith('#')) continue;
		const [probe, input, ...extra] = trimmed.split(/\s+/);
		if (!probe.endsWith('.dwl')) continue;
		const bound = parseArgs(extra.join(' ').replace(/@/g, `${rel}/`));
		if (input && input !== '-') bound.inputs.unshift({ name: 'payload', fixture: `${rel}/${input}` });
		found.set(probe.slice(0, -4), bound);
	}
	return found;
}

export async function discover(repoRoot: string): Promise<Chapter[]> {
	// This edition declares reading order and bindings explicitly. The old
	// discovery remains available for clones without the numbered catalogue.
	let manifestText: string | null = null;
	try { manifestText = await readFile(path.join(repoRoot, 'book/manifest.json'), 'utf8'); }
	catch (error) { if ((error as NodeJS.ErrnoException).code !== 'ENOENT') throw error; }
	if (manifestText !== null) {
		const chapters = JSON.parse(manifestText) as Chapter[];
		const scratch = await readdir(path.join(repoRoot, 'scratch')).catch(() => [] as string[]);
		const inputs = scratch.filter(name => INPUT_EXT.has(path.extname(name))).sort().map(name => `scratch/${name}`);
		if (inputs.length) chapters.push({ id: 'scratch', examples: [], inputs });
		return chapters;
	}
	const base = path.join(repoRoot, 'chapters');
	let dirs: string[];
	try {
		dirs = (await readdir(base, { withFileTypes: true })).filter((d) => d.isDirectory()).map((d) => d.name).sort();
	} catch {
		return [];
	}

	const chapters: Chapter[] = [];
	// A gitignored folder for a reader's own files. It sits inside the repository,
	// so the Runner can bind it without mounting anything new into the container
	// or widening what the server will read.
	const scratch = await readdir(path.join(repoRoot, 'scratch')).catch(() => [] as string[]);
	const scratchInputs = scratch
		.filter((entry) => INPUT_EXT.has(path.extname(entry)))
		.sort()
		.map((entry) => `scratch/${entry}`);
	if (scratchInputs.length) chapters.push({ id: 'scratch', examples: [], inputs: scratchInputs });
	for (const chapter of dirs) {
		const entries = await readdir(path.join(base, chapter));
		const examples: Example[] = [];
		const inputs: string[] = [];
		const dwlNames = entries.filter((e) => e.endsWith('.dwl')).map((e) => e.slice(0, -4));
		const runScript = await readFile(path.join(base, chapter, 'run.sh'), 'utf8').catch(() => '');
		const manifest = await readFile(path.join(base, chapter, 'manifest'), 'utf8').catch(() => '');
		const bindings = runScript ? parseRunScript(runScript, chapter, dwlNames) : new Map<string, Bindings>();
		for (const [name, bound] of parseManifest(manifest, chapter)) bindings.set(name, bound);
		for (const entry of entries.sort()) {
			const ext = path.extname(entry);
			if (ext === '.dwl') {
				const name = entry.slice(0, -4);
				const out = entries.includes(`${name}.out`) ? `chapters/${chapter}/${name}.out` : undefined;
				// A `go` line if the chapter has one, the saved output's own header
				// otherwise. Both are the command that produced the .out beside it.
				let bound = bindings.get(name);
				if (!bound && out) {
					const saved = await readFile(path.join(repoRoot, out), 'utf8').catch(() => '');
					bound = parseSavedHeader(saved) ?? undefined;
				}
				examples.push({
					id: `${chapter}/${name}`,
					chapter,
					name,
					script: `chapters/${chapter}/${entry}`,
					savedOutput: out,
					bindings: bound,
				});
			} else if (INPUT_EXT.has(ext)) {
				inputs.push(`chapters/${chapter}/${entry}`);
			}
		}
		if (examples.length) chapters.push({ id: chapter, examples, inputs });
	}
	return chapters;
}

/** Read a repository file, refusing anything outside the repository. */
export async function readRepoFile(repoRoot: string, relative: string, limit = 2_000_000): Promise<string> {
	const abs = path.resolve(repoRoot, relative);
	if (abs !== repoRoot && !abs.startsWith(repoRoot + path.sep)) throw new Error('Path is outside the repository.');
	const info = await stat(abs);
	if (!info.isFile()) throw new Error('Not a file.');
	if (info.size > limit) throw new Error('That file is too large to open here.');
	return readFile(abs, 'utf8');
}

/**
 * The book's saved outputs end with an `exit=N` marker that `run.sh` appends.
 * Split it off so the playground can compare the transformation and the exit
 * status separately, and show the reader which of the two differs.
 */
export function splitSavedOutput(input: string): { body: string; exitCode: number | null } {
	// Drop the echoed command line. It is provenance, not output: no run produces
	// it, so leaving it in makes the comparison fail for every example that has one.
	const saved = input.replace(SAVED_HEADER, '');
	const match = saved.match(/exit=(\d+)\s*$/);
	if (!match) return { body: saved.replace(/\s*$/, ''), exitCode: null };
	return {
		body: saved.slice(0, match.index).replace(/\s*$/, ''),
		exitCode: Number(match[1]),
	};
}
