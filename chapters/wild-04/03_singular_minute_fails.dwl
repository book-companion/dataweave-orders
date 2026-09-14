%dw 2.0
output application/json
var placedAt = |2026-06-16T14:30:00-04:00|
---
{ minute: placedAt.minute }
