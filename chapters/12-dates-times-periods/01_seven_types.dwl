%dw 2.0
output application/json
var values = {
  date:          |2026-06-16|,
  localTime:     |14:30:00|,
  time:          |14:30:00Z|,
  localDateTime: |2026-06-16T14:30:00|,
  dateTime:      |2026-06-16T14:30:00-04:00|,
  zone:          |-04:00|,
  period:        |P1Y2M10D|
}
---
values mapObject { ($$): { value: $, kind: typeOf($) as String } }
