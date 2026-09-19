/**
 * Proves the playground reproduces the book.
 *
 * Each chapter's `run.sh` is what produced the saved `.out` files, so this reads
 * those scripts, replays every `go` line through the playground's HTTP API with
 * the same bindings, and compares the result with what the book printed.
 *
 *   make playground            # in one terminal
 *   node playground/selfcheck.mjs [--all] [--chapter 01-a-functional-language]
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
				// A literal carries no MIME type. Giving it one hides the chapter's
				// point, which is that the engine refuses a literal without an
				// `input` directive.
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
/**
 * What the page will bind, against what run.sh bound.
 *
 * This check exists because the numbers above cannot see the page. Every
 * example here passed while the browser was binding the chapter's first JSON
 * file to `payload` whatever the example actually read — wrong for 72 of 137,
 * and reported to the reader as Differs. This replays run.sh directly, so it
 * proves the engine; only comparing the server's declared bindings with the
 * same parse proves what a reader will actually run.
 */
const bindingMismatches = [];
const sameBindings = (a, b) =>
	JSON.stringify({ i: a.inputs, p: a.params, m: a.modulePaths }) ===
	JSON.stringify({ i: b.inputs, p: b.params, m: b.modulePaths });

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

		if (!example.bindings) bindingMismatches.push({ id: example.id, why: 'server declares none' });
		else if (!sameBindings(example.bindings, testCase)) {
			bindingMismatches.push({
				id: example.id,
				why: `server ${JSON.stringify(example.bindings.inputs)} vs run.sh ${JSON.stringify(testCase.inputs)}`,
			});
		}

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

/**
 * The 137 above are the examples whose chapters use `go` lines. The other
 * eleven chapters drive a manifest or a loop, and their bindings come off the
 * saved output's own header — 370 more examples the page will happily open and
 * compare. Check those too, using what the server declares, because that is
 * what a reader actually runs.
 */
let wide = 0, wideMatched = 0, wideDrift = 0;
const wideFailures = [];
for (const chapter of chapters) {
	if (ONLY && chapter.id !== ONLY) continue;
	for (const example of chapter.examples) {
		if (!example.savedOutput || !example.bindings) continue;
		const { content: script } = await get(`/api/file?path=${encodeURIComponent(example.script)}`);
		const { saved } = await get(`/api/file?path=${encodeURIComponent(example.savedOutput)}`);
		if (!saved) continue;
		const res = await fetch(BASE + '/api/run', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				script,
				inputs: example.bindings.inputs,
				scriptName: example.name,
				modulePaths: example.bindings.modulePaths,
				params: example.bindings.params,
			}),
		}).then((r) => r.json());
		wide++;
		const got = (res.output ?? '').trim();
		const want = saved.body.trim();
		const sameExit = saved.exitCode === null || saved.exitCode === res.exitCode;
		if (got === want && sameExit) wideMatched++;
		else if (sameExit && identityHash(got) === identityHash(want)) wideDrift++;
		else if (NONDETERMINISTIC.test(script)) wideDrift++;
		else wideFailures.push({ id: example.id, exit: `${res.exitCode} vs ${saved.exitCode}` });
	}
}

console.log(`checked ${checked} · matched ${matched} · expected drift ${drifted} · differs ${failures.length}`);
console.log(
	`whole catalogue: ran ${wide} · matched ${wideMatched} · expected drift ${wideDrift} · differs ${wideFailures.length}`,
);
for (const f of wideFailures.slice(0, 10)) console.log(`  ${f.id}  exit ${f.exit}`);
console.log(
	bindingMismatches.length
		? `bindings the page would get wrong: ${bindingMismatches.length}`
		: `bindings: all ${checked} match what run.sh bound`,
);
for (const m of bindingMismatches.slice(0, 10)) console.log(`  ${m.id}  ${m.why}`);
if (noScript) console.log(`(${noScript} chapter(s) have no run.sh and were skipped)`);
for (const f of failures.slice(0, 8)) {
	console.log(`\n  ${f.id}  exit ${f.exit}`);
	console.log(`    book: ${JSON.stringify(f.want.slice(0, 160))}`);
	console.log(`    here: ${JSON.stringify(f.got.slice(0, 160))}`);
}
process.exit(failures.length || bindingMismatches.length || wideFailures.length ? 1 : 0);
