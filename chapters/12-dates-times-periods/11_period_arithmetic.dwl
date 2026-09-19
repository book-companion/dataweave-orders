%dw 2.0
output application/json
var placedAt = |2026-06-16T14:30:00-04:00|
---
{
  shipBy:     placedAt + |P2D|,
  returnBy:   placedAt + |P30D|,
  lastMonth:  placedAt - |P1M|,
  sixHours:   placedAt + |PT6H|,
  monthEnd:   |2026-01-31| + |P1M|,
  leapDay:    |2024-02-29| + |P1Y|,
  dateMinusDate: |2026-06-18| - |2026-06-16|,
  dtMinusDt:  |2026-06-18T15:30:00Z| - |2026-06-16T09:00:00Z|
}
