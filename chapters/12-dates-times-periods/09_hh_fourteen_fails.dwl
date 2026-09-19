%dw 2.0
output application/json
---
{ afternoon: "14:00" as LocalTime {format: "hh:mm"} }
