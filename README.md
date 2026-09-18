# DataWeave orders companion

Companion code for *DataWeave in Depth* by Simon Sarkar, the second book of the pair that starts with *Mule from Scratch*. It holds the book's DataWeave scripts, input fixtures and saved outputs, chapter by chapter, and runs them with the pinned DataWeave CLI. You need Docker and Python 3; no Anypoint account is required.

## Run it

```bash
make image    # builds the pinned DataWeave CLI 2.12.0 image (engine 2.12.2)
make verify   # two golden checks: the opening order summary and the final XML-to-JSON report
```

`make verify` compares parsed JSON with the saved results and fails on a changed value or an unexpected process failure. It is a small smoke suite, not a re-run of every chapter. The image pins the CLI release; its Debian base is not guaranteed to rebuild byte for byte over time.

## DataWeave Runner, in your browser

```bash
make playground   # http://127.0.0.1:4444
```

Three panes — input, script, result — running on the same pinned CLI, offline.
Bind a file from this repository and read its contents beside your script, or
type an input inline. Open any example from the book and the Runner will tell
you whether your result matches the one the book printed. See
[`playground/README.md`](playground/README.md).

## Run one script from the shell

To run one script, pass its input and module path through `dw.sh`. The capstone, for example:

```bash
./dw.sh run -s -i payload=chapters/wild-08/feed.xml --path=chapters/wild-08 -f chapters/wild-08/04_final.dwl
```

## Layout

`chapters/language-01` to `language-08` hold chapters 1–8, and `chapters/wild-01` to `wild-08` hold chapters 9–16. The directory names keep the original experiment numbering. Each one holds the chapter's scripts, small fixtures, modules and saved `.out` files. Many examples fail on purpose, and each saved output records the expected exit. Timestamps, UUIDs, object identity strings and some diagnostic ordering vary between runs.

Each chapter directory has a `run.sh` that regenerates its saved outputs. Keep a clean copy before running one, because it overwrites the files the book quotes.

## What is not here

The streaming chapter's large-input memory harness is not included; its small transforms are. The CLI has no Java, Excel or flat-file readers, so those examples live in the [MuleSoft companion](https://github.com/book-companion/mulesoft-orders), which runs them under a Mule runtime. Custom POJOs, tagged multi-record flat-file schemas and deployment are outside this suite. No Mule runtime or credentials are included.
