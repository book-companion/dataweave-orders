%dw 2.0
output application/json
---
{ order: { id: payload.orderId, contact: payload.customer.email } }
