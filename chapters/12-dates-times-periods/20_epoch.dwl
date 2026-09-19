%dw 2.0
output application/json
---
{
  fromSeconds:  1781555400 as DateTime,
  fromMillis:   1781555400000 as DateTime {unit: "milliseconds"},
  toNumber:     |2026-06-16T14:30:00-04:00| as Number,
  toMillis:     |2026-06-16T14:30:00-04:00| as Number {unit: "milliseconds"},
  millisWrong:  1781555400000 as DateTime
}
