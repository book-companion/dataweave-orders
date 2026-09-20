# Numbered example index

Numbers follow first appearance in the book. Script outputs and bindings are recorded in [manifest.json](manifest.json).

## 01 — Your First DataWeave Script

| Example | Source | Kind |
| --- | --- | --- |
| 1 | [Hello from DataWeave](01-your-first-script/001-hello-from-dataweave.dwl) | script |
| 2 | [A fixed order header](01-your-first-script/002-a-fixed-order-header.dwl) | script |
| 3 | [Return a single value](01-your-first-script/003-return-a-single-value.dwl) | script |
| 4 | [A missing comma](01-your-first-script/004-a-missing-comma.dwl) | script |
| 5 | [Add an order status](01-your-first-script/005-add-an-order-status.dwl) | script |

## 02 — Read an Object and Build Another

| Example | Source | Kind |
| --- | --- | --- |
| 6 | [Read the order header](02-read-and-build-objects/006-read-the-order-header.dwl) | script |
| 7 | [Rename an output field](02-read-and-build-objects/007-rename-an-output-field.dwl) | script |
| 8 | [Read a nested customer](02-read-and-build-objects/008-read-a-nested-customer.dwl) | script |
| 9 | [Select a quoted key](02-read-and-build-objects/009-select-a-quoted-key.dwl) | script |
| 10 | [Inspect a missing field](02-read-and-build-objects/010-inspect-a-missing-field.dwl) | script |
| 11 | [Build a nested order result](02-read-and-build-objects/011-build-a-nested-order-result.dwl) | script |

## 03 — Calculate with Values and Convert Deliberately

| Example | Source | Kind |
| --- | --- | --- |
| 12 | [Calculate one line](03-values-and-conversions/012-calculate-one-line.dwl) | script |
| 13 | [Name the line calculation](03-values-and-conversions/013-name-the-line-calculation.dwl) | script |
| 14 | [Inspect scalar types](03-values-and-conversions/014-inspect-scalar-types.dwl) | script |
| 15 | [Convert a supplier price](03-values-and-conversions/015-convert-a-supplier-price.dwl) | script |
| 16 | [Arithmetic and concatenation](03-values-and-conversions/016-arithmetic-and-concatenation.dwl) | script |
| 17 | [Reject a nonnumeric price](03-values-and-conversions/017-reject-a-nonnumeric-price.dwl) | script |
| 18 | [Division produces a number](03-values-and-conversions/018-division-produces-a-number.dwl) | script |
| 19 | [Discount one line](03-values-and-conversions/019-discount-one-line.dwl) | script |

## 04 — Make Decisions and Handle Missing Fields

| Example | Source | Kind |
| --- | --- | --- |
| 20 | [Choose a delivery label](04-decisions-and-missing-data/020-choose-a-delivery-label.dwl) | script |
| 21 | [Use a decision in an object](04-decisions-and-missing-data/021-use-a-decision-in-an-object.dwl) | script |
| 22 | [Default only an absent value](04-decisions-and-missing-data/022-default-only-an-absent-value.dwl) | script |
| 23 | [Handle empty notes](04-decisions-and-missing-data/023-handle-empty-notes.dwl) | script |
| 24 | [Require an order identifier](04-decisions-and-missing-data/024-require-an-order-identifier.dwl) | script |
| 25 | [Guard a conversion](04-decisions-and-missing-data/025-guard-a-conversion.dwl) | script |
| 26 | [Normalize an optional note](04-decisions-and-missing-data/026-normalize-an-optional-note.dwl) | script |

## 05 — Give a Calculation a Function

| Example | Source | Kind |
| --- | --- | --- |
| 27 | [Call a line-total function](05-functions/027-call-a-line-total-function.dwl) | script |
| 28 | [Give a parameter a default](05-functions/028-give-a-parameter-a-default.dwl) | script |
| 29 | [Declare numeric parameters](05-functions/029-declare-numeric-parameters.dwl) | script |
| 30 | [Reject an incompatible argument](05-functions/030-reject-an-incompatible-argument.dwl) | script |
| 31 | [Keep intermediate values local](05-functions/031-keep-intermediate-values-local.dwl) | script |
| 32 | [Check the receipt boundary](05-functions/032-check-the-receipt-boundary.dwl) | script |

## 06 — Transform Every Item with map

| Example | Source | Kind |
| --- | --- | --- |
| 33 | [Inspect an item array](06-arrays-and-map/033-inspect-an-item-array.dwl) | script |
| 34 | [Map an array of numbers](06-arrays-and-map/034-map-an-array-of-numbers.dwl) | script |
| 35 | [Calculate every line](06-arrays-and-map/035-calculate-every-line.dwl) | script |
| 36 | [Build a result for each line](06-arrays-and-map/036-build-a-result-for-each-line.dwl) | script |
| 37 | [Number the order lines](06-arrays-and-map/037-number-the-order-lines.dwl) | script |
| 38 | [Map an empty array](06-arrays-and-map/038-map-an-empty-array.dwl) | script |
| 39 | [Rename every line](06-arrays-and-map/039-rename-every-line.dwl) | script |

## 07 — Select Lines and Calculate an Order Total

| Example | Source | Kind |
| --- | --- | --- |
| 40 | [Keep the bulk lines](07-filter-and-totals/040-keep-the-bulk-lines.dwl) | script |
| 41 | [Count and total selected lines](07-filter-and-totals/041-count-and-total-selected-lines.dwl) | script |
| 42 | [Order totals](07-filter-and-totals/042-order-totals.dwl) | script |
| 43 | [An empty order total](07-filter-and-totals/043-an-empty-order-total.dwl) | script |
| 44 | [Read the shorthand after the named form](07-filter-and-totals/044-read-the-shorthand-after-the-named-form.dwl) | script |
| 45 | [Check an empty selection](07-filter-and-totals/045-check-an-empty-selection.dwl) | script |

## 08 — Sort, Select and Remove Duplicates

| Example | Source | Kind |
| --- | --- | --- |
| 46 | [Sort the line quantities](08-sorting-and-selection/046-sort-the-line-quantities.dwl) | script |
| 47 | [Choose which fields define a duplicate](08-sorting-and-selection/047-distinctby.dwl) | script |
| 48 | [Sort by price and product name](08-sorting-and-selection/048-orderby-asc.dwl) | script |
| 49 | [Select an array range](08-sorting-and-selection/049-ranges.dwl) | script |
| 50 | [Check range boundaries](08-sorting-and-selection/050-range-bounds.dwl) | script |
| 51 | [Sort numbers in descending order](08-sorting-and-selection/051-orderby-desc-number.dwl) | script |
| 52 | [Try negating a string sort key](08-sorting-and-selection/052-orderby-desc-string-negate.dwl) | script |
| 53 | [Reverse a sorted string array](08-sorting-and-selection/053-orderby-desc-string-reverse.dwl) | script |
| 54 | [Reverse an array with a range](08-sorting-and-selection/054-orderby-desc-string-range.dwl) | script |
| 55 | [Try sorting with an array key](08-sorting-and-selection/055-orderby-array-key.dwl) | script |
| 56 | [Sort by category and quantity](08-sorting-and-selection/056-orderby-two-keys.dwl) | script |

## 09 — Work with Nested Collections

| Example | Source | Kind |
| --- | --- | --- |
| 57 | [Keep orders and their lines nested](09-nested-collections/057-keep-orders-and-their-lines-nested.dwl) | script |
| 58 | [Inspect shorthand inside nested callbacks](09-nested-collections/058-nested-dollar.dwl) | script |
| 59 | [Name both nested callback parameters](09-nested-collections/059-nested-named.dwl) | script |
| 60 | [Flatten one level at a time](09-nested-collections/060-flatten-levels.dwl) | script |
| 61 | [Flatten mapped order lines](09-nested-collections/061-flatmap-orders.dwl) | script |
| 62 | [Select SKUs three ways](09-nested-collections/062-three-ways-to-sku.dwl) | script |
| 63 | [Select repeated object keys](09-nested-collections/063-repeated-keys.dwl) | script |
| 64 | [Limit the scope of a descendant search](09-nested-collections/064-descendant-everything.dwl) | script |
| 65 | [Observe missing fields in a projection](09-nested-collections/065-projection-drops-missing.dwl) | script |
| 66 | [Count quantities with three selectors](09-nested-collections/066-count-quantities-with-three-selectors.dwl) | script |

## 10 — Transform Object Fields and Keys

| Example | Source | Kind |
| --- | --- | --- |
| 67 | [Construct a dynamic field name](10-object-transformations/067-dynamic-key.dwl) | script |
| 68 | [Splice field pairs into an object](10-object-transformations/068-spread.dwl) | script |
| 69 | [Collect duplicate fields into arrays](10-object-transformations/069-spread-dupkeys-asarray.dwl) | script |
| 70 | [Include a field conditionally](10-object-transformations/070-conditional-key.dwl) | script |
| 71 | [Try unless in a conditional field](10-object-transformations/071-conditional-key-unless.dwl) | script |
| 72 | [Negate a field condition](10-object-transformations/072-conditional-key-negated.dwl) | script |
| 73 | [Choose a fallback with unless](10-object-transformations/073-unless-expression.dwl) | script |
| 74 | [Transform object fields with mapObject](10-object-transformations/074-mapobject.dwl) | script |
| 75 | [Remove null object fields](10-object-transformations/075-filterobject-nulls.dwl) | script |
| 76 | [Turn fields into entries](10-object-transformations/076-turn-fields-into-entries.dwl) | script |
| 77 | [Merge defaults and inspect entries](10-object-transformations/077-merge-defaults-and-inspect-entries.dwl) | script |
| 78 | [Compare merge and concatenation](10-object-transformations/078-compare-merge-and-concatenation.dwl) | script |
| 79 | [Choose whether null replaces a default](10-object-transformations/079-mergewith-null.dwl) | script |
| 80 | [Pair arrays with zip](10-object-transformations/080-zip.dwl) | script |
| 81 | [Uppercase object keys](10-object-transformations/081-uppercase-object-keys.dwl) | script |

## 11 — Group Records into Reports

| Example | Source | Kind |
| --- | --- | --- |
| 82 | [Group lines by category](11-grouped-reports/082-groupby-category.dwl) | script |
| 83 | [Inspect numeric group keys](11-grouped-reports/083-groupby-number-key.dwl) | script |
| 84 | [Turn groups into summary rows](11-grouped-reports/084-pluck-summary.dwl) | script |
| 85 | [Inspect pluck callback parameters](11-grouped-reports/085-pluck-positional.dwl) | script |
| 86 | [Name the stages of a category report](11-grouped-reports/086-name-the-stages-of-a-category-report.dwl) | script |
| 87 | [A sort inside the wrong expression](11-grouped-reports/087-precedence-swallowed.dwl) | script |
| 88 | [Sort the completed category report](11-grouped-reports/088-putting-together.dwl) | script |
| 89 | [Summarize units per order](11-grouped-reports/089-summarize-units-per-order.dwl) | script |
| 90 | [Find the highest-revenue SKU](11-grouped-reports/090-find-the-highest-revenue-sku.dwl) | script |

## 12 — Enrich Records from a Lookup

| Example | Source | Kind |
| --- | --- | --- |
| 91 | [Read a catalogue lookup](12-lookups-and-joins/091-read-a-catalogue-lookup.dwl) | script |
| 92 | [Build a unique name lookup](12-lookups-and-joins/092-build-a-unique-name-lookup.dwl) | script |
| 93 | [Keep unmatched lines in a left join](12-lookups-and-joins/093-leftjoin-short.dwl) | script |
| 94 | [Keep duplicate catalogue matches visible](12-lookups-and-joins/094-keep-duplicate-catalogue-matches-visible.dwl) | script |

## 13 — Carry a Result through reduce

| Example | Source | Kind |
| --- | --- | --- |
| 95 | [Seed a running sum](13-reduce/095-seed-a-running-sum.dwl) | script |
| 96 | [Distinguish the item from the accumulator](13-reduce/096-reduce-positional-swapped.dwl) | script |
| 97 | [Compare seeded and unseeded folds](13-reduce/097-reduce-seed-forms.dwl) | script |
| 98 | [An accumulator starts with the wrong type](13-reduce/098-reduce-unseeded-type.dwl) | script |
| 99 | [Build an object with a seeded fold](13-reduce/099-reduce-to-object.dwl) | script |
| 100 | [Try building an object without a seed](13-reduce/100-reduce-to-object-unseeded.dwl) | script |
| 101 | [Keep a history of running totals](13-reduce/101-running-total.dwl) | script |
| 102 | [Flatten arrays with a fold](13-reduce/102-reduce-flatten.dwl) | script |
| 103 | [Sum, count and partition by a predicate](13-reduce/103-arrays.dwl) | script |
| 104 | [Check and select array members](13-reduce/104-arrays-more-short.dwl) | script |
| 105 | [Calculate an order total with reduce](13-reduce/105-total.dwl) | script |
| 106 | [Count qualifying items with a fold](13-reduce/106-count-qualifying-items-with-a-fold.dwl) | script |
| 107 | [Choose the largest line amount](13-reduce/107-choose-the-largest-line-amount.dwl) | script |

## 14 — State Contracts and Branch on Input Shape

| Example | Source | Kind |
| --- | --- | --- |
| 108 | [Check scalar and collection types](14-contracts-and-patterns/108-is.dwl) | script |
| 109 | [Define order and line contracts](14-contracts-and-patterns/109-custom-types.dwl) | script |
| 110 | [Reject an unknown literal-type value](14-contracts-and-patterns/110-literal-type-as-fails.dwl) | script |
| 111 | [Try coercing a whole object](14-contracts-and-patterns/111-object-type-as.dwl) | script |
| 112 | [Declare a structural function parameter](14-contracts-and-patterns/112-fun-signature.dwl) | script |
| 113 | [Reject an incompatible function input](14-contracts-and-patterns/113-fun-signature-rejects.dwl) | script |
| 114 | [Reject an incompatible return value](14-contracts-and-patterns/114-fun-return-type-rejects.dwl) | script |
| 115 | [Match literal values](14-contracts-and-patterns/115-match-literal.dwl) | script |
| 116 | [Inspect an unmatched value](14-contracts-and-patterns/116-match-no-match.dwl) | script |
| 117 | [Match by type](14-contracts-and-patterns/117-match-type.dwl) | script |
| 118 | [Add guards to matching cases](14-contracts-and-patterns/118-match-guard.dwl) | script |
| 119 | [Guard a customer tier](14-contracts-and-patterns/119-guard-a-customer-tier.dwl) | script |
| 120 | [Fill a missing tag](14-contracts-and-patterns/120-fill-a-missing-tag.dwl) | script |
| 121 | [Choose shipping with guarded cases](14-contracts-and-patterns/121-choose-shipping-with-guarded-cases.dwl) | script |

## 15 — Share Helpers and Automate Their Checks

| Example | Source | Kind |
| --- | --- | --- |
| 122 | [Shared order calculations](15-modules-and-checks/122-shared-order-calculations.dwl) | module |
| 123 | [Reject a module with a body](15-modules-and-checks/123-module-with-body-fails.dwl) | script |
| 124 | [Import the order module functions](15-modules-and-checks/124-import-star.dwl) | script |
| 125 | [Call the module with a missing quantity](15-modules-and-checks/125-type-mismatch-fails.dwl) | script |
| 126 | [Call the module with a textual price](15-modules-and-checks/126-type-mismatch-string.dwl) | script |
| 127 | [A second line-total implementation](15-modules-and-checks/127-a-second-line-total-implementation.dwl) | module |
| 128 | [Inspect colliding selective imports](15-modules-and-checks/128-ambiguous-import.dwl) | script |
| 129 | [Alias the two line-total functions](15-modules-and-checks/129-alias-both.dwl) | script |
| 130 | [Keep a module binding in its own scope](15-modules-and-checks/130-use-module-fun-shadows-var.dwl) | script |
| 131 | [Try the dw::test modules in the CLI](15-modules-and-checks/131-dwtest.dwl) | script |
| 132 | [Check a table of function cases](15-modules-and-checks/132-assert-in-script.dwl) | script |
| 133 | [Make a failed assertion stop the command](15-modules-and-checks/133-assert-fail-loud.dwl) | script |
| 134 | [Normalize an order with module functions](15-modules-and-checks/134-normalize-order.dwl) | script |
| 135 | [Compare net and taxed line totals](15-modules-and-checks/135-alias-both.dwl) | script |

## 16 — Clean Text and Extract Patterns

| Example | Source | Kind |
| --- | --- | --- |
| 136 | [Clean labels and identifiers](16-text-and-patterns/136-clean-labels-and-identifiers.dwl) | script |
| 137 | [Inspect string boundaries](16-text-and-patterns/137-inspect-string-boundaries.dwl) | script |
| 138 | [Interpolate a value into text](16-text-and-patterns/138-interpolate-a-value-into-text.dwl) | script |
| 139 | [Match, scan and split with patterns](16-text-and-patterns/139-regex-more.dwl) | script |
| 140 | [Try a dollar-one replacement string](16-text-and-patterns/140-replace-dollar-one.dwl) | script |
| 141 | [Build replacement text from a match](16-text-and-patterns/141-replace-lambda.dwl) | script |
| 142 | [Reject an incomplete regular expression](16-text-and-patterns/142-regex-fails.dwl) | script |
| 143 | [Match cases with regular expressions](16-text-and-patterns/143-match-regex.dwl) | script |
| 144 | [Check whether a pattern matches](16-text-and-patterns/144-matches-operator.dwl) | script |
| 145 | [Extract SKU components](16-text-and-patterns/145-extract-sku-components.dwl) | script |

## 17 — Readers, Writers and the JSON Contract

| Example | Source | Kind |
| --- | --- | --- |
| 146 | [Parse a JSON document inside a field](17-readers-writers-json/146-parse-a-json-document-inside-a-field.dwl) | script |
| 147 | [Write compact JSON](17-readers-writers-json/147-indent-false.dwl) | script |
| 148 | [Reject an unknown JSON writer property](17-readers-writers-json/148-unknown-writer-property.dwl) | script |
| 149 | [Omit null object fields](17-readers-writers-json/149-omit-null-object-fields.dwl) | script |
| 150 | [Try an unsupported null policy](17-readers-writers-json/150-skipnull-nowhere.dwl) | script |
| 151 | [Omit an absent field deliberately](17-readers-writers-json/151-conditional-key.dwl) | script |
| 152 | [Write repeated JSON keys](17-readers-writers-json/152-duplicate-keys-write.dwl) | script |
| 153 | [Read repeated JSON keys](17-readers-writers-json/153-read-repeated-json-keys.dwl) | script |
| 154 | [Write repeated values as an array](17-readers-writers-json/154-duplicate-keys-collapse.dwl) | script |
| 155 | [Inspect JSON field order](17-readers-writers-json/155-key-order.dwl) | script |
| 156 | [Inspect numeric values and their types](17-readers-writers-json/156-numbers.dwl) | script |
| 157 | [Format a monetary amount](17-readers-writers-json/157-money-format.dwl) | script |
| 158 | [Distinguish null from a missing field](17-readers-writers-json/158-null-vs-missing.dwl) | script |
| 159 | [Escape characters in a JSON string](17-readers-writers-json/159-string-escaping.dwl) | script |
| 160 | [Parse and format numeric text](17-readers-writers-json/160-number-format.dwl) | script |
| 161 | [Compare whole and decimal numbers](17-readers-writers-json/161-one-number.dwl) | script |
| 162 | [Reject an unquoted JSON key](17-readers-writers-json/162-reject-an-unquoted-json-key.dwl) | script |
| 163 | [Write compact JSON without object nulls](17-readers-writers-json/163-write-compact-json-without-object-nulls.dwl) | script |
| 164 | [Select both duplicate values](17-readers-writers-json/164-select-both-duplicate-values.dwl) | script |

## 18 — Read and Produce Reliable CSV

| Example | Source | Kind |
| --- | --- | --- |
| 165 | [Read CSV rows](18-csv/165-read-csv-rows.dwl) | script |
| 166 | [Inspect CSV string values](18-csv/166-inspect-csv-string-values.dwl) | script |
| 167 | [Read headerless data with default settings](18-csv/167-noheader-default.dwl) | script |
| 168 | [Declare a headerless CSV input](18-csv/168-noheader-directive.dwl) | script |
| 169 | [Read headerless CSV text](18-csv/169-read-headerless-csv-text.dwl) | script |
| 170 | [Read semicolon-separated rows](18-csv/170-semicolon-directive.dwl) | script |
| 171 | [Try parsing a decimal comma directly](18-csv/171-decimal-comma-fails.dwl) | script |
| 172 | [Normalize a decimal comma before conversion](18-csv/172-decimal-comma-fixed.dwl) | script |
| 173 | [Read doubled quote characters](18-csv/173-doubled-quote-escape.dwl) | script |
| 174 | [Choose CSV quoting and escaping](18-csv/174-write-quoting.dwl) | script |
| 175 | [Locate a CSV header after a preamble](18-csv/175-locate-a-csv-header-after-a-preamble.dwl) | script |
| 176 | [Inspect CSV column order](18-csv/176-writer-key-order.dwl) | script |
| 177 | [Reject a nested CSV field](18-csv/177-write-nested-fails.dwl) | script |
| 178 | [Write quoted semicolon-separated fields](18-csv/178-write-props.dwl) | script |
| 179 | [Normalize an uploaded CSV file](18-csv/179-worked-upload.dwl) | script |
| 180 | [Write tab-separated output](18-csv/180-write-tab-separated-output.dwl) | script |
| 181 | [Total European price strings](18-csv/181-total-european-price-strings.dwl) | script |
| 182 | [Name headerless columns](18-csv/182-name-headerless-columns.dwl) | script |

## 19 — Read and Write XML Orders

| Example | Source | Kind |
| --- | --- | --- |
| 183 | [Select XML attributes](19-xml-orders/183-select-xml-attributes.dwl) | script |
| 184 | [Inspect an XML attribute object](19-xml-orders/184-attribute-object.dwl) | script |
| 185 | [Check the types of XML text values](19-xml-orders/185-text-is-string.dwl) | script |
| 186 | [Write XML elements and attributes](19-xml-orders/186-attributes-write.dwl) | script |
| 187 | [Select one or all repeated elements](19-xml-orders/187-single-vs-many-three.dwl) | script |
| 188 | [Select an absent element collection](19-xml-orders/188-many-on-none.dwl) | script |
| 189 | [A single element is not an array](19-xml-orders/189-a-single-element-is-not-an-array.dwl) | script |
| 190 | [Compare XML descendant selectors](19-xml-orders/190-compare-xml-descendant-selectors.dwl) | script |
| 191 | [Try writing two XML roots](19-xml-orders/191-two-roots-output.dwl) | script |
| 192 | [Try writing an array at the XML root](19-xml-orders/192-array-root-output.dwl) | script |
| 193 | [Put repeated elements under one root](19-xml-orders/193-array-root-fixed.dwl) | script |
| 194 | [Reject malformed XML](19-xml-orders/194-reject-malformed-xml.dwl) | script |
| 195 | [Build XML order elements](19-xml-orders/195-build-xml-order-elements.dwl) | script |
| 196 | [Preserve a one-item array](19-xml-orders/196-preserve-a-one-item-array.dwl) | script |

## 20 — Handle XML Namespaces and Content

| Example | Source | Kind |
| --- | --- | --- |
| 197 | [Select namespaced XML elements](20-xml-namespaces-and-content/197-namespace-select.dwl) | script |
| 198 | [Match a namespace with a different prefix](20-xml-namespaces-and-content/198-namespace-other-prefix.dwl) | script |
| 199 | [Read a default XML namespace](20-xml-namespaces-and-content/199-default-namespace.dwl) | script |
| 200 | [Write a namespaced XML order](20-xml-namespaces-and-content/200-namespace-write.dwl) | script |
| 201 | [Inspect mixed XML text](20-xml-namespaces-and-content/201-inspect-mixed-xml-text.dwl) | script |
| 202 | [Read CDATA as text](20-xml-namespaces-and-content/202-cdata.dwl) | script |
| 203 | [Write a CDATA value](20-xml-namespaces-and-content/203-cdata-write.dwl) | script |
| 204 | [Inspect an empty XML element](20-xml-namespaces-and-content/204-empty-elements.dwl) | script |
| 205 | [Read empty XML elements](20-xml-namespaces-and-content/205-read-empty-xml-elements.dwl) | script |
| 206 | [Write null values as XML](20-xml-namespaces-and-content/206-null-to-xml.dwl) | script |
| 207 | [Choose the XML declaration and indentation](20-xml-namespaces-and-content/207-writer-props.dwl) | script |
| 208 | [Select an XML output encoding](20-xml-namespaces-and-content/208-encoding.dwl) | script |
| 209 | [Normalize a namespaced XML feed](20-xml-namespaces-and-content/209-worked-feed.dwl) | script |
| 210 | [Read and write embedded formats](20-xml-namespaces-and-content/210-read-and-write-embedded-formats.dwl) | script |
| 211 | [Preserve XML attributes in JSON output](20-xml-namespaces-and-content/211-write-attributes.dwl) | script |
| 212 | [Reject XML presented as JSON](20-xml-namespaces-and-content/212-reject-xml-presented-as-json.dwl) | script |
| 213 | [Write a wrapped summary as YAML](20-xml-namespaces-and-content/213-write-a-wrapped-summary-as-yaml.dwl) | script |

## 21 — Parse and Format Dates

| Example | Source | Kind |
| --- | --- | --- |
| 214 | [Parse a declared date layout](21-date-parsing/214-parse-a-declared-date-layout.dwl) | script |
| 215 | [Parse and format temporal values](21-date-parsing/215-parse-format.dwl) | script |
| 216 | [Confuse month and minute tokens](21-date-parsing/216-mm-trap-parse.dwl) | script |
| 217 | [Inspect invalid calendar dates](21-date-parsing/217-lenient-day-overflow.dwl) | script |

## 22 — Preserve Instants and Calculate Intervals

| Example | Source | Kind |
| --- | --- | --- |
| 218 | [Inspect the seven temporal types](22-time-zones-and-intervals/218-seven-types.dwl) | script |
| 219 | [Convert between temporal types](22-time-zones-and-intervals/219-coercions.dwl) | script |
| 220 | [Read the clock and select date components](22-time-zones-and-intervals/220-now-truncations.dwl) | script |
| 221 | [Shift an instant to another offset](22-time-zones-and-intervals/221-shift-offsets.dwl) | script |
| 222 | [Compare a named zone with a fixed offset](22-time-zones-and-intervals/222-dst-named-vs-offset.dwl) | script |
| 223 | [Format an instant and its zone](22-time-zones-and-intervals/223-format-tokens.dwl) | script |
| 224 | [Convert epoch seconds and milliseconds](22-time-zones-and-intervals/224-epoch.dwl) | script |
| 225 | [Add and subtract calendar periods](22-time-zones-and-intervals/225-period-arithmetic.dwl) | script |
| 226 | [Construct periods and calculate intervals](22-time-zones-and-intervals/226-periods-module.dwl) | script |
| 227 | [Construct dates and find calendar boundaries](22-time-zones-and-intervals/227-dates-module.dwl) | script |
| 228 | [Calculate ship dates from a European feed](22-time-zones-and-intervals/228-eu-feed.dwl) | script |
| 229 | [Normalize a mixed date feed](22-time-zones-and-intervals/229-normalize-a-mixed-date-feed.dwl) | script |
| 230 | [Group timestamps by local date](22-time-zones-and-intervals/230-group-timestamps-by-local-date.dwl) | script |
| 231 | [Format a feed date and amount](22-time-zones-and-intervals/231-format-a-feed-date-and-amount.dwl) | script |

## 23 — Build and Verify the Order Report

| Example | Source | Kind |
| --- | --- | --- |
| 232 | [Inspect the batch shape](23-order-report/232-inspect-the-batch-shape.dwl) | script |
| 233 | [The feed normalization and report module](23-order-report/233-the-feed-normalization-and-report-module.dwl) | module |
| 234 | [Normalize the batch](23-order-report/234-normalize-the-batch.dwl) | script |
| 235 | [Build the order report](23-order-report/235-build-the-order-report.dwl) | script |
| 236 | [Report an order with no lines](23-order-report/236-report-an-order-with-no-lines.dwl) | script |
| 237 | [Verify report reconciliation](23-order-report/237-verify-report-reconciliation.dwl) | script |
| 238 | [Revenue by customer tier](23-order-report/238-revenue-by-customer-tier.dwl) | script |
| 239 | [Write report totals as XML](23-order-report/239-write-report-totals-as-xml.dwl) | script |

## 24 — Understand the Cost of a Transformation

| Example | Source | Kind |
| --- | --- | --- |
| 240 | [Map a streamed five-order input](24-streaming-and-performance/240-streaming-five.dwl) | script |
| 241 | [Reject object syntax in reader directives](24-streaming-and-performance/241-brace-syntax-fails.dwl) | script |
| 242 | [Pass streaming options to read](24-streaming-and-performance/242-pass-streaming-options-to-read.dwl) | script |
| 243 | [Count a streamed input](24-streaming-and-performance/243-sizeof-streaming.dwl) | script |
| 244 | [Count with a streamed fold](24-streaming-and-performance/244-reduce-streaming.dwl) | script |
| 245 | [Sort a streamed input](24-streaming-and-performance/245-orderby-streaming.dwl) | script |
| 246 | [Read a streamed input more than once](24-streaming-and-performance/246-twice-streaming.dwl) | script |
| 247 | [Declare a stream-capable parameter](24-streaming-and-performance/247-streamcapable.dwl) | script |

## 25 — Appendix A: Runner and CLI Reference

| Example | Source | Kind |
| --- | --- | --- |
| 248 | [Read CLI environment parameters](25-appendix-runner/248-read-cli-environment-parameters.dwl) | script |
| 249 | [Convert a CLI rate parameter](25-appendix-runner/249-convert-a-cli-rate-parameter.dwl) | script |

## 26 — Appendix B: Functions as Values, in Depth

| Example | Source | Kind |
| --- | --- | --- |
| 250 | [Returning a function value from map](26-appendix-functions/250-returning-a-function-value-from-map.dwl) | script |
| 251 | [Call a function with too few arguments](26-appendix-functions/251-arity-too-few.dwl) | script |
| 252 | [Use a default parameter](26-appendix-functions/252-use-a-default-parameter.dwl) | script |
| 253 | [Call a function declared later](26-appendix-functions/253-fun-forward-reference.dwl) | script |
| 254 | [Declare the same function signature twice](26-appendix-functions/254-fun-duplicate-same-sig.dwl) | script |
| 255 | [Try writing a function value as JSON](26-appendix-functions/255-lambda-as-output-fails.dwl) | script |
| 256 | [Annotate a lambda parameter](26-appendix-functions/256-typed-lambda.dwl) | script |
| 257 | [Select a function overload](26-appendix-functions/257-overloading.dwl) | script |
| 258 | [Calculate with a recursive function](26-appendix-functions/258-recursion.dwl) | script |
| 259 | [Call a lambda for each line](26-appendix-functions/259-call-a-lambda-for-each-line.dwl) | script |
| 260 | [Call a named function inside map](26-appendix-functions/260-call-a-named-function-inside-map.dwl) | script |
| 261 | [Pass a function to prefix map](26-appendix-functions/261-pass-a-function-to-prefix-map.dwl) | script |
| 262 | [Declare a function-valued parameter](26-appendix-functions/262-function-typed-param.dwl) | script |
| 263 | [Reject an incompatible function argument](26-appendix-functions/263-function-typed-param-rejects.dwl) | script |
| 264 | [Inspect map shorthand parameters](26-appendix-functions/264-inspect-map-shorthand-parameters.dwl) | script |
| 265 | [Inspect object callback shorthand](26-appendix-functions/265-shorthands-object.dwl) | script |
| 266 | [Reject a third map parameter](26-appendix-functions/266-reject-a-third-map-parameter.dwl) | script |
| 267 | [Compare prefix and infix calls](26-appendix-functions/267-prefix-infix.dwl) | script |
| 268 | [Reject a three-argument infix call](26-appendix-functions/268-reject-a-three-argument-infix-call.dwl) | script |
| 269 | [Return a function with a bound discount](26-appendix-functions/269-currying.dwl) | script |
| 270 | [Map with a curried function](26-appendix-functions/270-map-with-a-curried-function.dwl) | script |
| 271 | [Compose two calculations](26-appendix-functions/271-compose.dwl) | script |
| 272 | [Change the order of composition](26-appendix-functions/272-compose-order-matters.dwl) | script |
| 273 | [Apply a function argument](26-appendix-functions/273-apply-a-function-argument.dwl) | script |
| 274 | [Compose discount and tax](26-appendix-functions/274-compose-discount-and-tax.dwl) | script |
| 275 | [Call an overload with a Boolean](26-appendix-functions/275-overloading-no-match.dwl) | script |

## 27 — Appendix C: Additional Formats and Mule Integration

| Example | Source | Kind |
| --- | --- | --- |
| 276 | [Try Java output in the CLI](27-appendix-formats/276-java-output.dwl) | script |
| 277 | [Produce Java scalar objects in Mule](27-appendix-formats/277-produce-java-scalar-objects-in-mule.dwl) | manual |
| 278 | [Inspect Java scalar classes in Mule](27-appendix-formats/278-inspect-java-scalar-classes-in-mule.dwl) | manual |
| 279 | [Read fixed-width customers in Mule](27-appendix-formats/279-read-fixed-width-customers-in-mule.dwl) | manual |
| 280 | [Parse fixed-width fields with string ranges](27-appendix-formats/280-fixed-width-by-hand.dwl) | script |
| 281 | [Round-trip an Excel sheet in Mule](27-appendix-formats/281-round-trip-an-excel-sheet-in-mule.dwl) | manual |
| 282 | [Read multipart content](27-appendix-formats/282-read-multipart-content.dwl) | script |
| 283 | [Write multipart content](27-appendix-formats/283-multipart-write.dwl) | script |

## 28 — Appendix D: Library and Behavior Reference

| Example | Source | Kind |
| --- | --- | --- |
| 284 | [Combine object paths and array indexes](28-appendix-reference/284-dots-and-indexes.dwl) | script |
| 285 | [Select fields with brackets](28-appendix-reference/285-brackets.dwl) | script |
| 286 | [Continue a selection through null](28-appendix-reference/286-select-on-null.dwl) | script |
| 287 | [Try selecting an object field from text](28-appendix-reference/287-select-on-string-fails.dwl) | script |
| 288 | [Apply indexes to different value types](28-appendix-reference/288-index-on-object.dwl) | script |
| 289 | [Convert scalar values explicitly](28-appendix-reference/289-as-basics.dwl) | script |
| 290 | [Reject nonnumeric text during conversion](28-appendix-reference/290-as-fails-number.dwl) | script |
| 291 | [Try coercing null to a number](28-appendix-reference/291-as-null-fails.dwl) | script |
| 292 | [Reject a date with no declared layout](28-appendix-reference/292-reject-a-date-with-no-declared-layout.dwl) | script |
| 293 | [Parse a feed date and add a week](28-appendix-reference/293-date-parse.dwl) | script |
| 294 | [Inspect a date's retained format](28-appendix-reference/294-schema-sticks.dwl) | script |
| 295 | [Reject a date with the wrong layout](28-appendix-reference/295-date-parse-wrong-format.dwl) | script |
| 296 | [Compare numeric formatting patterns](28-appendix-reference/296-number-format.dwl) | script |
| 297 | [Group a conversion before arithmetic](28-appendix-reference/297-as-precedence.dwl) | script |
| 298 | [Call a function without importing it](28-appendix-reference/298-import-not-imported.dwl) | script |
| 299 | [Import every module function](28-appendix-reference/299-import-wildcard.dwl) | script |
| 300 | [Import selected module functions](28-appendix-reference/300-import-selective.dwl) | script |
| 301 | [Alias a module import](28-appendix-reference/301-import-alias.dwl) | script |
| 302 | [Import a function that does not exist](28-appendix-reference/302-import-unknown-function.dwl) | script |
| 303 | [Import a module that does not exist](28-appendix-reference/303-import-unknown-module.dwl) | script |
| 304 | [Inspect a module name collision](28-appendix-reference/304-import-collision.dwl) | script |
| 305 | [Calculate numeric aggregates and rounding](28-appendix-reference/305-numbers-core.dwl) | script |
| 306 | [Try averaging an empty array](28-appendix-reference/306-numbers-core-fails.dwl) | script |
| 307 | [Select temporal components](28-appendix-reference/307-components.dwl) | script |
| 308 | [Try the singular minute selector](28-appendix-reference/308-singular-minute-fails.dwl) | script |
| 309 | [Distinguish empty text from null](28-appendix-reference/309-distinguish-empty-text-from-null.dwl) | script |
| 310 | [Combine module and local helpers](28-appendix-reference/310-combine-module-and-local-helpers.dwl) | script |
| 311 | [Alias two module paths](28-appendix-reference/311-alias-two-module-paths.dwl) | script |
| 312 | [Qualify colliding module functions](28-appendix-reference/312-qualify-colliding-module-functions.dwl) | script |
| 313 | [Merge defaults and partition order lines](28-appendix-reference/313-merge-defaults-and-partition-order-lines.dwl) | script |
| 314 | [Reject a variable forward reference](28-appendix-reference/314-reject-a-variable-forward-reference.dwl) | script |
| 315 | [Call a function that reads a later binding](28-appendix-reference/315-call-a-function-that-reads-a-later-binding.dwl) | script |
| 316 | [Keep an inner rate local](28-appendix-reference/316-keep-an-inner-rate-local.dwl) | script |
| 317 | [Inspect model value types](28-appendix-reference/317-inspect-model-value-types.dwl) | script |
| 318 | [Inspect the same fields in a text feed](28-appendix-reference/318-inspect-the-same-fields-in-a-text-feed.dwl) | script |
