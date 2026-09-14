%dw 2.0
output application/json
---
{ indexOnNumber: payload.shipping.price[0] }
