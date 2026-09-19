%dw 2.0
output application/json
---
{ s: payload.items[0] as String }
