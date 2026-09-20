%dw 2.0
output application/json
---
{ orderId: payload.orderId, shipping: if (payload.total >= 100) 0 else 4.99, label: if (payload.total == 0) "empty" else "ready" }
