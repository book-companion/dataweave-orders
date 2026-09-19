%dw 2.0
output application/json
var sku = "AC-1099-XL"
---
{
  wholeString:   "AC-1099" matches /\d+/,
  anchoredFull:  "AC-1099" matches /[A-Z]+-\d+/,
  containsInstead: "AC-1099" contains /\d+/,
  matchGroups:   sku match /([A-Z]+)-(\d+)-(\w+)/,
  matchNothing:  "nope" match /(\d+)/,
  scanAll:       "PEN-01, PAD-22, CLP-08" scan /[A-Z]+-\d+/,
  scanNothing:   "nope" scan /\d+/,
  splitRegex:    "a, b,c ,d" splitBy /\s*,\s*/
}
