# DataWeave Runner

Write a script, bind an input, press Run. A companion to *DataWeave in Depth*
that runs on your machine, against the pinned CLI that produced every output
printed in the book.

An input can come from a file in this repository — its contents are shown, not
just its name — or be typed inline. Switching a file input to inline carries its
contents across, so changing the book's fixture is one click and an edit.

```bash
make runner       # Docker only — builds one image and serves it
```

Or, with Node on your machine and the engine image already built:

```bash
make image        # once: builds dw-cli:2.12.0 from the Dockerfile
make playground   # then: http://127.0.0.1:4444
```

**`make runner` needs only Docker.** There is one image and one Dockerfile: it
carries the engine and the Node that serves this page, both installed the same
way, from pinned release tarballs. `make runner` publishes the page to your
loopback address with the repository mounted read-only. The image runs the
engine by default, so serving the page overrides the entrypoint — which is the
only difference between the two roles. Each run is then a subprocess
beside the server rather than a container of its own, which is also why it is
faster — about 180 ms against 450.

That trade is worth stating. On the host path every run gets its own container:
no network, capabilities dropped, memory and process caps, thrown away
afterwards. Served from inside, those become the one container's, set once at start. The
guard that was always doing the real work is unchanged — the engine is still
given `--untrusted`, so a script reads the inputs bound to it and nothing else.
`selfcheck.mjs` passes identically either way, which is the point of having it.

**The host path needs Node 22.6 or newer, and Docker.** Nothing to install: the page's JavaScript is
committed, and Node runs the server's TypeScript directly. `start.mjs` works out
whether your Node needs `--experimental-strip-types` — it was required when type
stripping arrived, became the default in 22.18 and 23.6, and passing it on a Node
that has since dropped it would fail. Tested on Node v22.17.0.

## Why this and not the hosted one

The hosted playground is excellent for a first five minutes and this is not
trying to replace it. But three things make a local one worth having:

**It runs the book's engine.** The pin is `dw-cli:2.12.0`, reporting language
runtime 2.12.2 — the version every example in the book was executed against.
The hosted playground tells you the language version (`2.0`) and not the engine
release, so you cannot tell whether a difference you are looking at is your
mistake or a version gap.

**It can tell you whether you got it right.** Open any example from the picker
and press Run: the pane underneath compares your result with the output the book
printed, exit code included. That comparison is only possible because the saved
`.out` files sit beside the scripts in this repository.

**Nothing leaves your machine.** Everything runs in a container with
`--network none`. The hosted playground's terms ask you to accept on your
employer's behalf and not to submit personal or regulated data — reasonable
terms for a public sandbox, and a poor fit for the order and customer payloads
you actually work on.

## What it does with your script

Each run writes the script to a throwaway directory and executes the pinned
image with this repository mounted read-only:

```
docker run --rm --network none --memory 512m --pids-limit 256 \
  --cap-drop ALL --security-opt no-new-privileges \
  -v <repo>:/lab:ro -v <tmp>:/work -w /work dw-cli:2.12.0 \
  run -s --untrusted --path /lab/chapters/<chapter> -i payload=… -f /work/<name>.dwl
```

`--path` is sent only when you ask for it — the **resolve modules from …** switch
above the script. One example in the modules chapter omits it deliberately, to
show what an unresolved import looks like, so supplying one always would erase
the lesson.

## Where an input comes from

Each input card offers three sources, and only the first is read by the server.

**Book** lists every fixture in this repository — the orders, feeds and CSVs the
chapters use — and shows the chosen file's contents underneath. Drop your own
files in `scratch/` at the root of the repository and they appear in the same
list. That folder is gitignored, so your own orders stay out of git, and it is
inside the repository, which is already mounted read-only, so nothing new
reaches the container.

**File** opens anything on your machine through the browser's own picker. The
browser reads it and posts the text, so the server gains no ability to read
anything new. Files above 2 MB are refused: the whole thing is held in memory
and sent with every run.

**Inline** is a box you type in. Switching to it from either of the others
carries the contents across, which is how "what if this field were missing?"
becomes one click and an edit.

Paths outside the repository are refused, on purpose: this is a local HTTP
service that runs scripts, and the less of your disk it can name, the better.

The **params** box under the inputs passes `-p name=value` pairs. They arrive in
a script as a `params` object — `params.env` — and always as strings, so coerce
them (`params.taxRate as Number`) when you need a number. Two examples in the
book use them; chapter 14 explains why.

`--untrusted` means the script has no privileges: it cannot read files or URLs,
only the inputs you bind. Most of the book needs nothing more. The **Allow file
& URL reads** switch drops that flag for the chapters that do — `readUrl`, for
instance — and the container still has no network.

Two details that exist so results match the book rather than merely resembling
it. The script is written under the **name of the example you opened**, because
DataWeave puts the script's file name in its error messages and the book quotes
those verbatim. And the JVM warnings the native image prints on every run are
filtered exactly as `run.sh` filters them — but each stream is filtered
separately, because the CLI's stdout has no trailing newline, and concatenating
stderr first puts a successful run's closing `}` on the same line as a warning,
where the filter eats it.

## Checking it against the book

`selfcheck.mjs` reads each chapter's `run.sh` — the script that produced the
saved outputs — replays every example through the playground with the same
bindings, and compares:

```bash
make playground                      # in one terminal
node playground/selfcheck.mjs --all  # in another
node playground/selfcheck.mjs --chapter language-01 --all
```

Three kinds of difference are reported as expected drift, the same three the
series record lists: `now()`, `uuid`, and the Java object-identity hash that a
type error against a JSON value prints (`JsonString@492fea76`). Everything else
is expected to match byte for byte.

As of this writing: **137 examples checked, 134 byte-identical, 3 expected
drift, 0 differing.**

## Editing it

`src/server.ts` serves and routes, `src/runner.ts` builds and runs the docker
command, `src/fixtures.ts` finds the book's examples, `src/client/app.ts` is the
page. After changing the client:

```bash
npm install && npm run build      # rebuilds public/app.js
```

The built file is committed on purpose, so that a reader who only wants to *use*
the playground never needs npm.

## Limits worth knowing

The CLI cannot read `application/flatfile`, `application/xlsx` or
`application/java`, and a `deferred=true` output produces nothing. Those are
limits of the command-line runtime, not of DataWeave, and the chapters that meet
them say so. A Mule runtime is the place to run that material.
