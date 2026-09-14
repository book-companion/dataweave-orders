%dw 2.0
import * from dw::core::Periods
output application/json
var placedAt  = |2026-06-16T09:00:00Z|
var shippedAt = |2026-06-18T15:30:00Z|
---
{
  window:      days(30),
  sixHours:    hours(6),
  turnaround:  between(shippedAt, placedAt),
  reversed:    between(placedAt, shippedAt),
  built:       period({ years: 1, months: 2, days: 10 }),
  duration:    duration({ hours: 6, minutes: 30 }),
  windowType:  typeOf(days(30)) as String
}
