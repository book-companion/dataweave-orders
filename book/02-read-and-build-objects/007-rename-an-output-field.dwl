%dw 2.0
output application/json
---
{ reference: payload.orderId, buyer: payload.customer }
