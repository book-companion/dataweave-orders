%dw 2.0
output application/json
---
{ first: payload[0].orderId }
