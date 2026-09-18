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

export interface Example {
	/** `language-01/02_summary` — what the picker shows and the client sends back. */
	id: string;
	chapter: string;
	name: string;
	script: string;
	/** Repo-relative path of the saved output, when the chapter kept one. */
	savedOutput?: string;
}

export interface Chapter {
	id: string;
	examples: Example[];
	inputs: string[];
}

const INPUT_EXT = new Set(['.json', '.xml', '.csv', '.yaml', '.yml', '.txt', '.properties', '.ffd']);

export async function discover(repoRoot: string): Promise<Chapter[]> {
	const base = path.join(repoRoot, 'chapters');
	let dirs: string[];
	try {
		dirs = (await readdir(base, { withFileTypes: true })).filter((d) => d.isDirectory()).map((d) => d.name).sort();
	} catch {
		return [];
	}

	const chapters: Chapter[] = [];
	for (const chapter of dirs) {
		const entries = await readdir(path.join(base, chapter));
		const examples: Example[] = [];
		const inputs: string[] = [];
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
