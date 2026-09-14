%dw 2.0
output application/json
---
{
  lookahead:  "AC-1099" matches /[A-Z]+-(?=1)\d+/,
  named:      "AC-1099" match /(?<family>[A-Z]+)-(?<num>\d+)/,
  wordBound:  "PEN-01 PAD-22" scan /\b[A-Z]{3}\b/,
  caseFlag:   "pen-01" matches /(?i)PEN-\d+/
}
