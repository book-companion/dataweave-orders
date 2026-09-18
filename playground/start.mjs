/**
 * Starts the playground on whatever Node the reader has.
 *
 * The server is written in TypeScript and Node runs it directly, but how it does
 * that moved twice: type stripping needed `--experimental-strip-types` when it
 * arrived, became the default in **22.18 and 23.6**, and is stable from 24.12.
 * Node 26 has already removed one of the experimental flags from that family, so
 * passing it unconditionally would break the readers on the newest runtimes —
 * the opposite of who you would expect a compatibility flag to hurt.
 *
 * This file is plain JavaScript on purpose: it has to parse on a Node that
 * cannot read the TypeScript it is about to launch, so that an old runtime gets
 * a sentence instead of a SyntaxError.
 */
import { spawn } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const HERE = path.dirname(fileURLToPath(import.meta.url));
const SERVER = path.join(HERE, 'src', 'server.ts');

const [major, minor] = process.versions.node.split('.').map(Number);
const atLeast = (wantMajor, wantMinor) => major > wantMajor || (major === wantMajor && minor >= wantMinor);

// Below this, Node cannot run TypeScript at all.
if (!atLeast(23, 0) && !(major === 22 && minor >= 6)) {
	process.stderr.write(
		`This playground needs Node 22.6 or newer — you are on ${process.versions.node}.\n` +
			`Node runs its TypeScript directly, and older versions cannot.\n` +
			`Upgrade Node, or run the book's examples from the shell with ./dw.sh instead.\n`,
	);
	process.exit(1);
}

// Default since 22.18 and 23.6; before that it needs the flag, and after Node
// removed flags from that family it must not be passed at all.
const needsFlag = !(atLeast(23, 6) || (major === 22 && minor >= 18));
const argv = needsFlag ? ['--experimental-strip-types', SERVER] : [SERVER];

const child = spawn(process.execPath, argv, { stdio: 'inherit' });

// Pass signals down, and take the server with us on the way out. Without this
// the server is only a child by accident: kill the launcher and the server is
// re-parented to init, still holding the port, and the next `make playground`
// fails with "address in use" pointing at a process nobody can see.
for (const signal of ['SIGINT', 'SIGTERM', 'SIGHUP']) {
	process.on(signal, () => {
		child.kill(signal);
		process.exit(0);
	});
}
process.on('exit', () => child.kill('SIGTERM'));

child.on('exit', (code, signal) => process.exit(signal ? 0 : code ?? 0));
