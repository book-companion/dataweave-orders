%dw 2.0
output application/json
var placedAt = |2026-06-16T14:30:00-04:00|
---
{
  original: placedAt,
  utc:      placedAt >> |+00:00|,
  la:       placedAt >> |-07:00|,
  laNamed:  placedAt >> "America/Los_Angeles",
  tokyo:    placedAt >> "Asia/Tokyo",
  sameInstant: (placedAt >> "Asia/Tokyo") == placedAt,
  dayInLa:  (placedAt >> "America/Los_Angeles").day
}
