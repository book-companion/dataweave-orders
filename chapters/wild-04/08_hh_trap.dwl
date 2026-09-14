%dw 2.0
output application/json
---
{
  withMarker: "02:00 PM" as LocalTime {format: "hh:mm a"},
  twentyFour: "14:00" as LocalTime {format: "HH:mm"},
  formatted:  |14:00:00| as String {format: "hh:mm"}
}
