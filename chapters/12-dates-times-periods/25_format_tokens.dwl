%dw 2.0
output application/json
var placedAt = |2026-06-16T14:30:00-04:00|
---
{
  dayName:    placedAt as String {format: "EEEE, d MMMM yyyy"},
  twelveHour: placedAt as String {format: "h:mm a"},
  offset:     placedAt as String {format: "yyyy-MM-dd'T'HH:mm:ssXXX"},
  zoneId:     (placedAt >> "America/New_York") as String {format: "HH:mm VV"},
  zoneName:   (placedAt >> "America/New_York") as String {format: "HH:mm zzz"},
  epochLike:  placedAt as String {format: "yyyyMMddHHmmss"}
}
