/**
 * Discovers the book's examples so the playground can open any of them.
 *
 * Every chapter folder holds its scripts (`NN_name.dwl`), the inputs they read,
 * and the output the book printed (`NN_name.out`). The third of those is what
 * makes this more useful than a hosted sandbox: a reader can run an example and
 * compare their result against the one on the page, byte for byte.
 */
import { readdir, readFile, stat } from 'node:fs/promises';
import path from 'node:path';

export interface Binding { name: string; fixture?: string; content?: string; format?: string }

/** Exactly what the book's own `run.sh` passed when it produced the saved output. */
export interface Bindings {
	inputs: Binding[];
	params: Array<{ name: string; value: string }>;
	modulePaths: string[];
}

export interface Example {
	/** `language-01/02_summary` — what the picker shows and the client sends back. */
	id: string;
	chapter: string;
	name: string;
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
function parseRunScript(source: string, chapter: string): Map<string, Bindings> {
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
		const args = expand(rest).match(/'[^']*'|"[^"]*"|\S+/g) ?? [];
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
				inputs.push({ name: n, content, format: 'application/json' });
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
		found.set(name, { inputs, params, modulePaths });
	}
	return found;
}

export async function discover(repoRoot: string): Promise<Chapter[]> {
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
		const runScript = await readFile(path.join(base, chapter, 'run.sh'), 'utf8').catch(() => '');
		const bindings = runScript ? parseRunScript(runScript, chapter) : new Map<string, Bindings>();
		for (const entry of entries.sort()) {
			const ext = path.extname(entry);
			if (ext === '.dwl') {
				const name = entry.slice(0, -4);
				const out = entries.includes(`${name}.out`) ? `chapters/${chapter}/${name}.out` : undefined;
				examples.push({
					id: `${chapter}/${name}`,
					chapter,
					name,
					script: `chapters/${chapter}/${entry}`,
					savedOutput: out,
					bindings: bindings.get(name),
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
export function splitSavedOutput(saved: string): { body: string; exitCode: number | null } {
	const match = saved.match(/exit=(\d+)\s*$/);
	if (!match) return { body: saved.replace(/\s*$/, ''), exitCode: null };
	return {
		body: saved.slice(0, match.index).replace(/\s*$/, ''),
		exitCode: Number(match[1]),
	};
}
