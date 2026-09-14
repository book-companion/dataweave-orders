%dw 2.0
output application/json
---
{ n: sizeOf(payload) }
