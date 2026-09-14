%dw 2.0
output application/json indent=false
---
{ id: payload.orderId, buyer: payload.customer, lineCount: sizeOf(payload.items) }
