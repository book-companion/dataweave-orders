# DataWeave orders companion

Companion to *DataWeave in Depth* by Simon Sarkar, following *MuleSoft from the Ground Up*. The progressive edition contains 24 chapters and four appendices. Examples start with Hello World, then grow through one order line, collections and a complete order report.

## Start reading and running

```sh
make runner
```

Open `http://127.0.0.1:4444` and choose **001 — Hello from DataWeave**. Docker is the only prerequisite for this route. The image pins DataWeave CLI 2.12.0, which reports language runtime 2.12.2. The first build downloads the tools.

## Find an example

The book's **318 listings** are numbered continuously by first appearance, including exercise answers. Each listing has a descriptive filename under `book/`. The [example index](book/README.md) maps every number to its source. The Runner opens the **311 runnable CLI scripts** with their declared fixtures, parameters, module paths and expected outputs. Three module listings are imported by other examples; four Mule-only listings retain the separately recorded evidence explained in Appendix C.

`book/manifest.json` is the Runner catalogue. `book/listings.json` includes the modules and Mule-only listings as well. An `.out` file contains recorded output followed by `exit=N`; an error can be the expected result. The web comparison checks text and exit status, removing CLI noise and trailing whitespace. Clock values and diagnostic identity hashes may differ; `make verify` checks the clock's fields and normalizes only identity suffixes.

The `chapters/` directory preserves the previous edition's 553 DataWeave source files, including modules, under their original filenames. It is an archive for old links and investigations; the current Runner uses `book/`. [Migration notes](book/MIGRATION.md) explain the new chapter sequence.

## Verify the book

```sh
make image
make verify
./check-golden.sh
```

`make verify` replays all 311 numbered CLI scripts in the pinned image. It checks catalogue order, expected errors, outputs, independent report totals, the empty-order result and rejection of a non-USD price. Negative controls prove that a wrong output and a repaired expected error are detected. It does not rerun the historical large-input memory measurements or the separate Mule probes.

`check-golden.sh` compares the serialized order result byte for byte and preserves a nonzero exit from either the engine or `diff`. It also accepts a replacement script path as its first argument, for testing a change against that same contract.

To check the browser API, start the Runner in one terminal, then use Node 22.6 or newer in another:

```sh
node playground/selfcheck.mjs --all
```

See [Runner documentation](playground/README.md) for editable inputs and local development. The compiled browser client is committed, so reading the book does not require npm.

## Run the capstone from the shell

```sh
./dw.sh run -s --path=book/23-order-report/modules \
  -i payload=book/23-order-report/inspect-the-batch-shape-input.xml \
  -f book/23-order-report/235-build-the-order-report.dwl
```

The source is normalized once before reporting. The module supplies the report functions; the script binds the XML fixture. Order totals are 32, 6 and 33, category totals are 53 and 18, and both reconcile to 71.

## Evidence boundaries

The CLI does not supply Java, Excel or fixed-width readers. The corresponding small probes were recorded using Mule 4.12.3 / DataWeave 2.12.3 / Java 17.0.13; their integration resources live in the [MuleSoft companion](https://github.com/book-companion/mulesoft-orders). No Mule runtime, account or credentials are included here. The performance chapter's small fixtures are runnable, while its 400,000-order memory results remain measurements from the original lab.
