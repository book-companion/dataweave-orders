%dw 2.0
output application/json
var placedAt = |2026-06-16T14:30:45.250-04:00|
---
{
  year:      placedAt.year,
  month:     placedAt.month,
  day:       placedAt.day,
  hour:      placedAt.hour,
  minutes:   placedAt.minutes,
  seconds:   placedAt.seconds,
  nanos:     placedAt.nanoseconds,
  dayOfWeek: placedAt.dayOfWeek,
  dayOfYear: placedAt.dayOfYear,
  quarter:   placedAt.quarter,
  timezone:  placedAt.timezone,
  offsetSeconds: placedAt.offsetSeconds
}
