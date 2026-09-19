%dw 2.0
output application/json
---
{ last: payload[-1].orderId, middle: payload[200000].orderId }
