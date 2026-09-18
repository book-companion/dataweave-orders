/**
 * Proves the playground reproduces the book.
 *
 * Each chapter's `run.sh` is what produced the saved `.out` files, so this reads
 * those scripts, replays every `go` line through the playground's HTTP API with
 * the same bindings, and compares the result with what the book printed.
 *
 *   make playground            # in one terminal
 *   node playground/selfcheck.mjs [--all] [--chapter language-01]
 *
 * It exists because the runner's first version lost a closing brace: the CLI's
 * stdout has no trailing newline, so concatenating stderr put `}` on the same
 * line as a JVM warning and the noise filter removed both. The server started
 * fine and the page looked right; only a comparison against the saved outputs
 * showed it.
 */
import { readFile } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const BASE = process.env.PG ?? 'http://127.0.0.1:4444';
const REPO = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const ALL = process.argv.includes('--all');
const ONLY = process.argv.includes('--chapter') ? process.argv[process.argv.indexOf('--chapter') + 1] : null;

/** now() and uuid change per run; the series record lists them as expected drift. */
const NONDETERMINISTIC = /\bnow\(\)|uuid|randomInt|random\b/;

/**
 * The third documented nondeterminism: a type error against a JSON-backed value
 * prints the Java object's identity hash, which is different on every run —
 * `JsonString@492fea76`. Normalising just that suffix lets the rest of the
 * message be compared strictly.
 */
const identityHash = (s) => s.replace(/@[0-9a-f]{4,}\b/g, '@HASH');

const get = async (p) => {
	const res = await fetch(BASE + p);
	if (!res.ok) throw new Error(`${p} -> ${res.status}`);
	return res.json();
};

/**
 * Pull the `go <name> [args]` lines out of a chapter's run.sh, expanding the
 * `$J` / `$X` / `$CSV` shorthands it defines for its fixtures.
 */
function parseRunScript(source, chapter) {
	const vars = { C: `chapters/${chapter}` };
	// run.sh defines its fixtures on ONE line — `J="…"; X="…"; CSV="…"` — so this
	// must not anchor to the start of a line, or only the first is ever found and
	// the XML and CSV examples silently run with no input at all.
	for (const m of source.matchAll(/\b([A-Z][A-Z0-9_]*)="([^"]*)"/g)) vars[m[1]] = m[2];
	// `J="-i payload=$C/order.json"` nests one variable inside another, so expand
	// until it settles rather than once.
	const expand = (s) => {
		let out = s;
		for (let i = 0; i < 5 && /\$[A-Za-z_]/.test(out); i++) {
			out = out.replace(/\$([A-Za-z_]+)/g, (_, n) => vars[n] ?? '');
		}
		return out;
	};

	const cases = [];
	for (const line of source.split('\n')) {
		const m = line.match(/^go\s+(\S+)\s*(.*)$/);
		if (!m) continue;
		const [, name, rest] = m;
		const args = expand(rest).match(/'[^']*'|"[^"]*"|\S+/g) ?? [];
		const inputs = [];
		const modulePaths = [];
		const params = [];
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
		cases.push({ name, inputs, modulePaths, params });
	}
	return cases;
}

const splitOnce = (s) => {
	const at = s.indexOf('=');
	return [s.slice(0, at), s.slice(at + 1)];
};

const { chapters } = await get('/api/examples');
let checked = 0, matched = 0, drifted = 0, noScript = 0;
const failures = [];

for (const chapter of chapters) {
	if (ONLY && chapter.id !== ONLY) continue;
	let runScript;
	try {
		runScript = await readFile(path.join(REPO, 'chapters', chapter.id, 'run.sh'), 'utf8');
	} catch {
		noScript++;
		continue;
	}

	for (const testCase of parseRunScript(runScript, chapter.id)) {
		const example = chapter.examples.find((e) => e.name === testCase.name);
		if (!example?.savedOutput) continue;

		const { content: script } = await get(`/api/file?path=${encodeURIComponent(example.script)}`);
		const { saved } = await get(`/api/file?path=${encodeURIComponent(example.savedOutput)}`);
		if (!saved) continue;

		const res = await fetch(BASE + '/api/run', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			// Run it under its own file name: DataWeave puts the script's name in
			// its error messages, and the book quotes those verbatim.
			body: JSON.stringify({
				script,
				inputs: testCase.inputs,
				scriptName: testCase.name,
				modulePaths: testCase.modulePaths,
				params: testCase.params,
			}),
		}).then((r) => r.json());

		checked++;
		const got = (res.output ?? '').trim();
		const want = saved.body.trim();
		const sameBody = got === want;
		const sameExit = saved.exitCode === null || saved.exitCode === res.exitCode;
		const onlyIdentityHash = !sameBody && identityHash(got) === identityHash(want);

		if (sameBody && sameExit) matched++;
		else if (sameExit && onlyIdentityHash) drifted++;
		else if (NONDETERMINISTIC.test(script)) drifted++;
		else failures.push({ id: example.id, exit: `${res.exitCode} vs ${saved.exitCode}`, sameBody, got: res.output ?? '', want: saved.body });

		if (!ALL && checked >= 30) break;
	}
	if (!ALL && checked >= 30) break;
}

console.log(`checked ${checked} · matched ${matched} · expected drift ${drifted} · differs ${failures.length}`);
if (noScript) console.log(`(${noScript} chapter(s) have no run.sh and were skipped)`);
for (const f of failures.slice(0, 8)) {
	console.log(`\n  ${f.id}  exit ${f.exit}`);
	console.log(`    book: ${JSON.stringify(f.want.slice(0, 160))}`);
	console.log(`    here: ${JSON.stringify(f.got.slice(0, 160))}`);
}
process.exit(failures.length ? 1 : 0);
