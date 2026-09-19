%dw 2.0
output application/json
---
{ d: payload.placed as Date }
