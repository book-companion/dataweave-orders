%dw 2.0
output application/json
var june     = |2026-06-16T18:30:00Z|
var december = |2026-12-16T18:30:00Z|
---
{
  juneNY:        june >> "America/New_York",
  decemberNY:    december >> "America/New_York",
  juneFixed:     june >> |-05:00|,
  decemberFixed: december >> |-05:00|,
  fallBack: [|2026-11-01T05:30:00Z|, |2026-11-01T06:30:00Z|] map ($ >> "America/New_York")
}
