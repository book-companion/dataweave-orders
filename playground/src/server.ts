/**
 * A local DataWeave playground, served from this repository.
 *
 *   node --experimental-strip-types playground/src/server.ts
 *   # or: make playground
 *
 * It binds to the loopback address only. It is a development tool that executes
 * scripts you type, through the pinned CLI in a container; it is not something
 * to expose to a network.
 */
import { createServer, type IncomingMessage, type ServerResponse } from 'node:http';
import { readFile } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { runScript, engineVersion, imageIsBuilt, IMAGE, type RunRequest } from './runner.ts';
import { discover, readRepoFile, splitSavedOutput } from './fixtures.ts';

const HERE = path.dirname(fileURLToPath(import.meta.url));
const PLAYGROUND = path.resolve(HERE, '..');
// Normally the repository this file sits in; in the one-image mode it is
// wherever the reader's clone is mounted.
const REPO_ROOT = process.env.DW_REPO ?? path.resolve(PLAYGROUND, '..');
const PUBLIC = path.join(PLAYGROUND, 'public');

const PORT = Number(process.env.PORT ?? 4444);
// Loopback on the host. Inside the container it binds to all interfaces, which
// is what lets Docker publish it back to 127.0.0.1 on the reader's machine —
// the port is published to loopback there, so it is still not on the network.
const HOST = process.env.HOST ?? '127.0.0.1';
const MAX_BODY = 4_000_000;

const TYPES: Record<string, string> = {
	'.html': 'text/html; charset=utf-8',
	'.css': 'text/css; charset=utf-8',
	'.js': 'text/javascript; charset=utf-8',
	'.svg': 'image/svg+xml',
};

function send(res: ServerResponse, status: number, body: string | Buffer, type = 'application/json'): void {
	res.writeHead(status, {
		'Content-Type': type,
		'Cache-Control': 'no-store',
		// The page loads only what this server sends it.
		'Content-Security-Policy': "default-src 'none'; script-src 'self'; style-src 'self'; connect-src 'self'",
		'X-Content-Type-Options': 'nosniff',
	});
	res.end(body);
}

const json = (res: ServerResponse, status: number, value: unknown) => send(res, status, JSON.stringify(value));

async function readBody(req: IncomingMessage): Promise<unknown> {
	const chunks: Buffer[] = [];
	let size = 0;
	for await (const chunk of req) {
		size += (chunk as Buffer).length;
		if (size > MAX_BODY) throw new Error('Request body is too large.');
		chunks.push(chunk as Buffer);
	}
	return JSON.parse(Buffer.concat(chunks).toString('utf8') || '{}');
}

async function serveStatic(res: ServerResponse, urlPath: string): Promise<void> {
	const rel = urlPath === '/' ? 'index.html' : urlPath.replace(/^\/+/, '');
	const abs = path.resolve(PUBLIC, rel);
	if (abs !== PUBLIC && !abs.startsWith(PUBLIC + path.sep)) return send(res, 403, 'Forbidden', 'text/plain');
	try {
		const body = await readFile(abs);
		send(res, 200, body, TYPES[path.extname(abs)] ?? 'application/octet-stream');
	} catch {
		send(res, 404, 'Not found', 'text/plain');
	}
}

const server = createServer((req, res) => {
	void handle(req, res).catch((err: unknown) => {
		const message = err instanceof Error ? err.message : 'Something went wrong.';
		json(res, 400, { error: message });
	});
});

async function handle(req: IncomingMessage, res: ServerResponse): Promise<void> {
	const url = new URL(req.url ?? '/', `http://${HOST}:${PORT}`);

	if (req.method === 'GET' && url.pathname === '/api/examples') {
		return json(res, 200, { image: IMAGE, chapters: await discover(REPO_ROOT) });
	}

	if (req.method === 'GET' && url.pathname === '/api/version') {
		return json(res, 200, { image: IMAGE, banner: await engineVersion() });
	}

	if (req.method === 'GET' && url.pathname === '/api/file') {
		const rel = url.searchParams.get('path') ?? '';
		const content = await readRepoFile(REPO_ROOT, rel);
		const saved = rel.endsWith('.out') ? splitSavedOutput(content) : null;
		return json(res, 200, { path: rel, content, saved });
	}

	if (req.method === 'POST' && url.pathname === '/api/run') {
		const body = (await readBody(req)) as RunRequest;
		const result = await runScript(REPO_ROOT, body);
		return json(res, 200, result);
	}

	if (req.method === 'GET') return serveStatic(res, url.pathname);
	send(res, 405, 'Method not allowed', 'text/plain');
}

server.on('error', (err: NodeJS.ErrnoException) => {
	if (err.code === 'EADDRINUSE') {
		process.stderr.write(
			`Port ${PORT} is already in use — the Runner may already be running.\n` +
				`  Open it:     http://${HOST}:${PORT}\n` +
				`  Elsewhere:   PORT=4500 make playground\n` +
				`  Or stop it:  lsof -ti tcp:${PORT} | xargs kill\n`,
		);
		process.exit(1);
	}
	throw err;
});

server.listen(PORT, HOST, () => {
	process.stdout.write(
		`DataWeave playground — http://${HOST}:${PORT}\n` +
			`engine image: ${IMAGE}  (the one the book's outputs were produced with)\n` +
			`serving examples from: ${REPO_ROOT}\n`,
	);
	// Say this at startup rather than leaving the reader to discover it on their
	// first Run, when docker's own message blames their credentials.
	void imageIsBuilt().then((built) => {
		if (!built) {
			process.stdout.write(
				`\nNOTE: ${IMAGE} is not built yet, so nothing will run.\n` +
					`      Build it once with:  make image\n`,
			);
		}
	});
});
