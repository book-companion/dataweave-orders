%dw 2.0
input payload application/json streaming=true
output application/json
---
{ last: payload[-1].orderId }
