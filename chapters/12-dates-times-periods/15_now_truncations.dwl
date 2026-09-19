%dw 2.0
output application/json
---
{
  now:      now(),
  asDate:   now() as Date,
  asLocal:  now() as LocalDateTime,
  zone:     now().timezone,
  today:    now() as String {format: "yyyy-MM-dd"}
}
