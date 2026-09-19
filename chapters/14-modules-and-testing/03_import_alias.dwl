%dw 2.0
import orderTotal as total from orders::OrderMath
output application/json
---
{ id: payload.orderId, total: total(payload.items) }
