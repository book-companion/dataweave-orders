%dw 2.0
import * from dw::core::Dates
output application/json
---
{
  built:        date({ year: 2026, month: 6, day: 16 }),
  builtDT:      dateTime({ year: 2026, month: 6, day: 16, hour: 14, minutes: 30, seconds: 0, timeZone: |-04:00| }),
  namedAsZone:  "America/New_York" as TimeZone,
  namedKind:    typeOf("America/New_York" as TimeZone) as String,
  startOfDay:   atBeginningOfDay(|2026-06-16T14:30:00-04:00|),
  startOfMonth: atBeginningOfMonth(|2026-06-16|),
  startOfWeek:  atBeginningOfWeek(|2026-06-16|)
}
