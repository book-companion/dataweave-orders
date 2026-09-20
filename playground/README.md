# DataWeave Runner

The Runner opens **001 — Hello from DataWeave** when it starts. Its catalogue follows the book's continuous example numbering and loads each script with the input, parameters, module paths and saved output it needs.

## Start it

From the companion root:

```sh
make runner
```

Open `http://127.0.0.1:4444`. Docker is the only prerequisite. The image contains the pinned CLI 2.12.0 / runtime 2.12.2 and the Node server. The repository is mounted read-only and the published port is bound to the host's loopback address.

For local development with Node 22.6 or newer:

```sh
make image
make playground
```

`start.mjs` selects the TypeScript-stripping flag required by the installed Node. This host route starts a separate container for each script. `make runner` instead executes the engine beside the server in one container.

## Open and edit an example

The Open menu lists the 311 runnable CLI examples from `book/manifest.json`. The [full index](../book/README.md) also lists the three module sources and four Mule-only probes, which are not standalone Runner scripts.

A selected example replaces the script and bindings together. A script with no inputs gets no invented payload. A script using XML, CSV or a particular JSON variant gets that exact fixture. The **Resolve modules** switch uses its declared module roots; disabling it can deliberately demonstrate an unresolved import.

Each input card offers three sources:

- **Book:** choose a repository fixture and inspect its contents. Files placed in the gitignored `scratch/` folder also appear here.
- **File:** the browser reads a local file and sends its text to the local server. The limit is 2 MB.
- **Inline:** type or edit the input directly. Switching from a file carries its contents into the editor.

The binding's name is the variable the script reads. A binding called `feed` is read as `feed`, not `vars.feed`; the standalone CLI does not supply a Mule event. The **params** box passes `name=value` pairs to the `params` object as strings.

Run with the button or Command/Ctrl+Enter. **Against the book** compares output text and exit status after CLI-noise removal and trailing-whitespace trimming. It does not compare parsed JSON: field ordering or a trailing decimal digit can produce a difference. Expected errors must still match the recorded error. Clock readings and diagnostic object identities may change between runs.

**Start from scratch** supplies a small greeting and an editable empty input. An unsaved script has no book result to compare against.

## Execution boundaries

Scripts use `--untrusted` by default. The engine can read the inputs explicitly bound to it, but file and URL reads require the **Allow file & URL reads** switch. The host route's per-run container also disables networking and sets memory/process limits. The combined web container needs its local browser connection and is not equivalent to that per-run isolation; keep the default untrusted mode for unfamiliar scripts.

The CLI cannot execute the book's Java, fixed-width or Excel probes. Appendix C identifies their separate Mule evidence. Deferred output also requires a consumer that actually consumes the stream; an empty successful CLI result is not a completed JSON document.

## Check the result path

With the Runner running, from the companion root:

```sh
node playground/selfcheck.mjs --all
node playground/selfcheck.mjs --chapter 01-your-first-script --all
```

The check compares the HTTP catalogue with the manifest, then replays the same bindings through `/api/run`. All 311 examples must match. It normalizes diagnostic identity suffixes and checks the clock example's declared fields and current UTC values. It does not waive other differences from a script merely because the script calls a clock.

`make verify` exercises the engine path as well as independent capstone invariants and negative controls. `./check-golden.sh` separately proves the shell's exact-output comparison and exit behavior.

## Edit the client

From `playground/`:

```sh
npm ci
npm run build
```

Commit `public/app.js` with the TypeScript change. The compiled client lets readers use the Runner without installing npm dependencies. `src/fixtures.ts` loads the catalogue, `src/runner.ts` invokes the engine, and `src/server.ts` serves the API and page.
