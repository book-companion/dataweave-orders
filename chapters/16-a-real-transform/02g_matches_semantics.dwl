%dw 2.0
output application/json
---
{
  stampAgainstPlainIso: "2026-06-18T09:30:00Z" matches /\d{4}-\d{2}-\d{2}/,
  prefixedIso:          "x2026-06-14" matches /\d{4}-\d{2}-\d{2}/,
  exactIso:             "2026-06-14" matches /\d{4}-\d{2}-\d{2}/,
  containsInstead:      "2026-06-18T09:30:00Z" contains /\d{4}-\d{2}-\d{2}/
}
