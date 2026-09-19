%dw 2.0
input payload application/json
output application/json
---
{ orderId: payload.orderId, lines: sizeOf(payload.items) }
