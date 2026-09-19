%dw 2.0
output application/json
var placedAt = |2026-06-16T14:30:00-04:00|
---
{
  toLocalDateTime: placedAt as LocalDateTime,
  toDate:          placedAt as Date,
  toLocalTime:     placedAt as LocalTime,
  toTime:          placedAt as Time,
  backAgain:       (placedAt as LocalDateTime) as DateTime,
  localToDT:       |2026-06-16T14:30:00| as DateTime,
  localToDTzone:   (|2026-06-16T14:30:00| as DateTime).timezone
}
