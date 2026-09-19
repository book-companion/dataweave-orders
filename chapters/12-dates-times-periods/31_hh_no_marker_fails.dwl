%dw 2.0
output application/json
---
{ morning: "02:00" as LocalTime {format: "hh:mm"} }
