%dw 2.0
output application/json
var a = |2026-06-16T14:30:00-04:00|
var b = |2026-06-16T18:30:00Z|
var c = |2026-06-17T03:30:00+09:00|
---
{
  aEqualsB:  a == b,
  aEqualsC:  a == c,
  aBeforeC:  a < c,
  sorted:    [c, a, |2026-06-16T10:00:00Z|] orderBy $,
  asText:    [a, b, c] map ($ as String)
}
