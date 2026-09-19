%dw 2.0
output application/json
---
{ oops: payload.customer * 2 }
