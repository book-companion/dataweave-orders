%dw 2.0
input payload application/json streaming=true
output application/json
---
{ n: sizeOf(payload), ids: (payload map $.orderId)[0 to 2] }
