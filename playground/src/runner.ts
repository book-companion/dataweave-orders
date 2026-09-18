/**
 * Runs a DataWeave script through the same pinned CLI image the book's examples
 * were produced with, and normalises its output the same way `run.sh` does.
 *
 * The point of this playground is that what you see in the browser is what the
 * book printed — same engine, same flags, same noise filter. A hosted sandbox
 * cannot promise that, because it will not tell you which engine it runs.
 */
import { execFile } from 'node:child_process';
import { mkdtemp, rm, writeFile, mkdir } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import path from 'node:path';

/** The image `make image` builds. Keep in step with the Dockerfile's ARG. */
export const IMAGE = process.env.DW_IMAGE ?? 'dw-cli:2.12.0';

/**
 * Set when the engine sits in the same container as this server, which is how
 * `make runner` starts it: the reader then needs Docker and nothing else, and
 * every run is a subprocess here rather than a container of its own.
 *
 * The per-run container is what supplied `--network none`, the dropped
 * capabilities and the memory and process caps. In this mode those are the
 * container's, set once when it starts. What does not change is the guard that
 * was always doing the real work — the engine is still given `--untrusted`.
 */
export const ENGINE = process.env.DW_BIN ?? null;

const RUN_TIMEOUT_MS = Number(process.env.DW_TIMEOUT_MS ?? 30_000);
const MAX_OUTPUT_BYTES = 1_000_000;

export interface RunInput {
	/** The DataWeave variable name: `payload`, or any identifier the script binds. */
	name: string;
	/** A file already in the repository, repo-relative — the book's fixtures. */
	fixture?: string;
	/** Content typed into the browser, written to a temp file before the run. */
	content?: string;
	/** Only used with `content`: decides the temp file's extension, and so the reader. */
	format?: string;
}

export interface RunRequest {
	script: string;
	inputs: RunInput[];
	/**
	 * The base name to give the script file. DataWeave quotes the script's file
	 * name in its error messages, and the book prints those messages verbatim —
	 * so an example loaded from `04_two_expressions_fail.dwl` has to run under
	 * that name, or every error example would appear to differ from the book.
	 */
	scriptName?: string;
	/**
	 * Repository-relative folders the engine resolves `import … from x::Y` against.
	 * The modules chapter passes `--path=chapters/wild-06`, and one of its examples
	 * passes nothing at all to show the failure — so this is optional, and when it
	 * is empty no `--path` is sent.
	 */
	modulePaths?: string[];
	/** `-p name=value` pairs, reachable inside a script as `params.name`. */
	params?: Array<{ name: string; value: string }>;
	/**
	 * Off by default. With it off the CLI is passed `--untrusted`, so the script
	 * has no privileges: no file reads, no URL reads, nothing outside its inputs.
	 * A playground runs text a reader pasted in, and most of the book's examples
	 * need nothing more than their declared inputs.
	 */
	allowPrivileges?: boolean;
}

export interface RunResult {
	output: string;
	exitCode: number;
	durationMs: number;
	timedOut: boolean;
	argv: string[];
}

/**
 * The CLI picks an input's reader from its file extension, so an inline payload
 * has to be written to a file named for the format the reader chose.
 */
const EXTENSION: Record<string, string> = {
	'application/json': 'json',
	'application/xml': 'xml',
	'application/csv': 'csv',
	'application/yaml': 'yaml',
	'text/plain': 'txt',
	'application/dw': 'dwl',
	'application/x-www-form-urlencoded': 'txt',
	'application/java-properties': 'properties',
};

const NAME = /^[A-Za-z_][A-Za-z0-9_]{0,63}$/;

/**
 * Strip what `run.sh` strips: ANSI colour, and the JVM warnings the native image
 * prints on every run. Without this the browser would show four lines of
 * `sun.misc.Unsafe` noise above every result, and a comparison against a saved
 * `.out` file would never match.
 */
const NOISE = /sun\.misc\.Unsafe|Please consider reporting|terminally deprecated|Weave Home directory/;

export function normalise(raw: string): string {
	return raw
		.replace(/\x1b\[[0-9;]*m/g, '')
		.split('\n')
		.filter((line) => !NOISE.test(line))
		.join('\n');
}

function fail(message: string): never {
	throw Object.assign(new Error(message), { userFacing: true });
}

/**
 * Build the docker argv. Separated from the run so a test — and the reader who
 * wants to know what just happened — can see the exact command.
 */
export function buildArgv(
	repoRoot: string,
	workDir: string,
	req: RunRequest,
	inputArgs: string[],
	scriptFile = 'main.dwl',
): string[] {
	return [
		'run', '--rm', '--platform', 'linux/amd64',
		// The repository is mounted read-only: it holds the book's fixtures and
		// its saved outputs, and nothing a pasted script does should touch them.
		'-v', `${repoRoot}:/lab:ro`,
		// One writable directory per run, thrown away afterwards.
		'-v', `${workDir}:/work`,
		'-w', '/work',
		// A transformation needs no network. This also means a script cannot call
		// out, whatever privileges the engine is given.
		'--network', 'none',
		'--memory', '512m', '--pids-limit', '256',
		'--cap-drop', 'ALL', '--security-opt', 'no-new-privileges',
		IMAGE,
		'run', '-s',
		...(req.allowPrivileges ? [] : ['--untrusted']),
		...modulePathArgs(repoRoot, req.modulePaths),
		...(req.params ?? []).flatMap(({ name, value }) => ['-p', `${name}=${value}`]),
		...inputArgs,
		'-f', `/work/${scriptFile}`,
	];
}

/**
 * `--path` is sent only when the caller asked for one. A chapter that omits it
 * is demonstrating what happens when the engine cannot find a module, and
 * helpfully supplying a path would erase the lesson.
 */
function modulePathArgs(repoRoot: string, paths: string[] | undefined): string[] {
	if (!paths?.length) return [];
	const mapped = paths.map((rel) => {
		const abs = path.resolve(repoRoot, rel);
		if (abs !== repoRoot && !abs.startsWith(repoRoot + path.sep)) fail('That module path is outside the repository.');
		const inside = path.relative(repoRoot, abs).split(path.sep).join('/');
		return inside ? `/lab/${inside}` : '/lab';
	});
	return ['--path', mapped.join(':')];
}

/**
 * The same engine invocation as `buildArgv`, minus the container around it.
 * Paths are real ones rather than the /lab and /work the mounts created.
 */
export function engineArgv(
	repoRoot: string,
	workDir: string,
	req: RunRequest,
	inputArgs: string[],
	scriptFile: string,
): string[] {
	const real = (p: string) => p.replace(/^\/lab\//, `${repoRoot}/`).replace(/^\/work\//, `${workDir}/`);
	return [
		'run', '-s',
		...(req.allowPrivileges ? [] : ['--untrusted']),
		...modulePathArgs(repoRoot, req.modulePaths).map((a) => (a === '--path' ? a : a.split(':').map(real).join(':'))),
		...(req.params ?? []).flatMap(({ name, value }) => ['-p', `${name}=${value}`]),
		...inputArgs.map((a) => (a === '-i' ? a : a.replace(/=(.*)$/, (_m, p) => `=${real(p)}`))),
		'-f', `${workDir}/${scriptFile}`,
	];
}

export async function runScript(repoRoot: string, req: RunRequest): Promise<RunResult> {
	if (typeof req.script !== 'string' || req.script.length === 0) fail('The script is empty.');
	if (req.script.length > 200_000) fail('That script is larger than this playground accepts.');
	if (!Array.isArray(req.inputs) || req.inputs.length > 16) fail('Too many inputs.');
	for (const p of req.params ?? []) if (!NAME.test(p.name ?? '')) fail(`"${p.name}" is not a usable parameter name.`);

	const base = /^[A-Za-z0-9_.-]{1,64}$/.test(req.scriptName ?? '') ? req.scriptName! : 'main';
	const scriptFile = `${base}.dwl`;
	const workDir = await mkdtemp(path.join(tmpdir(), 'dw-playground-'));
	try {
		await writeFile(path.join(workDir, scriptFile), req.script, 'utf8');
		const inputArgs: string[] = [];

		for (const input of req.inputs) {
			if (!NAME.test(input.name ?? '')) fail(`"${input.name}" is not a usable input name.`);
			if (input.fixture) {
				// A path from the repository. Resolve it and refuse anything that
				// climbs out, so the browser cannot read arbitrary files.
				const abs = path.resolve(repoRoot, input.fixture);
				if (abs !== repoRoot && !abs.startsWith(repoRoot + path.sep)) fail('That fixture is outside the repository.');
				inputArgs.push('-i', `${input.name}=/lab/${path.relative(repoRoot, abs).split(path.sep).join('/')}`);
			} else {
				const body = input.content ?? '';
				if (body.length > 2_000_000) fail(`Input "${input.name}" is too large.`);
				const ext = EXTENSION[input.format ?? 'application/json'] ?? 'txt';
				const file = `${input.name}.${ext}`;
				await writeFile(path.join(workDir, file), body, 'utf8');
				inputArgs.push('-i', `${input.name}=/work/${file}`);
			}
		}

		const argv = ENGINE
			? engineArgv(repoRoot, workDir, req, inputArgs, scriptFile)
			: buildArgv(repoRoot, workDir, req, inputArgs, scriptFile);
		const started = Date.now();
		const { code, out, timedOut } = await exec(ENGINE ?? 'docker', argv);
		const explained = explainDockerFailure(out, code);
		return {
			output: explained ?? normalise(out).replace(/\s*$/, ''),
			exitCode: code,
			durationMs: Date.now() - started,
			timedOut,
			argv,
		};
	} finally {
		await rm(workDir, { recursive: true, force: true }).catch(() => {});
	}
}

function exec(cmd: string, argv: string[]): Promise<{ code: number; out: string; timedOut: boolean }> {
	return new Promise((resolve) => {
		let timedOut = false;
		const child = execFile(
			cmd,
			argv,
			{ timeout: RUN_TIMEOUT_MS, maxBuffer: MAX_OUTPUT_BYTES, encoding: 'utf8' },
			(err, stdout, stderr) => {
				// Filter the two streams SEPARATELY, then join. Concatenating them
				// first is a trap: the CLI's stdout has no trailing newline, so a
				// successful run's closing `}` lands on the same line as the first
				// JVM warning — and the noise filter then eats the brace with it.
				// The book reports failures on stderr, so both streams are kept.
				const out = [normalise(stdout ?? ''), normalise(stderr ?? '')]
					.map((part) => part.replace(/\s+$/, ''))
					.filter(Boolean)
					.join('\n');
				const code = err && typeof (err as NodeJS.ErrnoException & { code?: number }).code === 'number'
					? Number((err as { code?: number }).code)
					: err ? 1 : 0;
				if (err && (err as NodeJS.ErrnoException).killed) timedOut = true;
				resolve({ code, out, timedOut });
			},
		);
		// Close the child's stdin at once. An example that binds no input reads
		// `payload` from stdin, and `docker run` without -i hands it a closed one:
		// the engine reports the empty input and exits 255, which is what the book
		// prints. A plain subprocess would sit on an open pipe instead and fail
		// differently, so the two modes must agree here.
		child.stdin?.end();
		child.on('error', () => resolve({ code: 127, out: 'Could not start the engine. Is Docker running?', timedOut: false }));
	});
}

/**
 * Docker's own messages are accurate and unhelpful: a reader who has not built
 * the image yet is told about `pull access denied`, which sounds like a
 * credentials problem and is really a missing `make image`. Translate the two
 * cases a first run actually hits.
 */
export function explainDockerFailure(out: string, code: number): string | null {
	if (/Cannot connect to the Docker daemon|docker daemon is not running/i.test(out)) {
		return 'Docker is not running. Start Docker Desktop and try again.';
	}
	if (code === 125 && /Unable to find image|pull access denied|repository does not exist/i.test(out)) {
		return `The engine image ${IMAGE} has not been built yet. Run \`make image\` once, then reload this page.`;
	}
	if (code === 127) return 'Could not start docker. Is it installed and on your PATH?';
	return null;
}

/** True when the pinned image is present locally. Used for the startup notice. */
export async function imageIsBuilt(): Promise<boolean> {
	if (ENGINE) return true; // it is right here
	const { code } = await exec('docker', ['image', 'inspect', IMAGE]);
	return code === 0;
}

/** The engine's own version banner, shown in the header so the pin is visible. */
export async function engineVersion(): Promise<string> {
	const { out, code } = ENGINE
		? await exec(ENGINE, ['--version'])
		: await exec('docker', ['run', '--rm', '--platform', 'linux/amd64', '--network', 'none', IMAGE, '--version']);
	const explained = explainDockerFailure(out, code);
	if (explained) throw new Error(explained);
	const clean = normalise(out).trim();
	return clean || 'unknown';
}

export async function ensureWorkRoot(dir: string): Promise<void> {
	await mkdir(dir, { recursive: true });
}
