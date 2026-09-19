%dw 2.0
output application/json
---
{
  jan31plus1M:       |2026-01-31| + |P1M|,
  thenMinus1M:       (|2026-01-31| + |P1M|) - |P1M|,
  jan31plus30D:      |2026-01-31| + |P30D|,
  roundTrip30D:      (|2026-01-31| + |P30D|) - |P30D|
}
