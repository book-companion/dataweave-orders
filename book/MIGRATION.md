# Progressive-edition migration

The original `chapters/` files remain available. New reading order and filenames live in `book/`; the Runner does not infer their bindings from directory contents.

| Previous subject | Current home |
| --- | --- |
| Functional introduction | Chapters 1–7, introduced one operation at a time |
| Selectors | Chapters 2, 8–9, 19–20 and Appendix D |
| Types and coercion | Chapters 3–4, 14, 17, 21–22 and Appendix D |
| Functions and lambdas | Chapters 5–6, 9 and Appendix B |
| map, filter and reduce | Chapters 6–7, 10 and 13 |
| Grouping and reshaping | Chapters 8–13 |
| Conditionals and pattern matching | Chapters 4, 14 and 16 |
| Scope and modules | Chapters 5, 15 and Appendix D |
| JSON and Java | Chapter 17 and Appendix C |
| XML | Chapters 19–20 |
| CSV and other formats | Chapter 18 and Appendix C |
| Dates and periods | Chapters 21–22 |
| Library | Chapters 10, 12–13, 16–17 and Appendix D |
| Modules and testing | Chapter 15 and Appendices A/C |
| Streaming and performance | Chapter 24 |
| Complete transform | Chapter 23 |
| Runner | Introduction and Appendix A |

The report now imports `book/23-order-report/modules/orders/Feed.dwl`. It separates XML normalization from calculations and handles absent line collections before mapping. Its numbered module listing and importable file must contain identical declarations.

Existing experiments retained their source behavior unless the book explains a correction. Scripts and saved diagnostics have been renamed to match their numbered listings. Current outputs were rerun on CLI 2.12.0 / runtime 2.12.2. Appendix C labels four Mule-only listings; the original Mule evidence was retained rather than represented as a new CLI run.
