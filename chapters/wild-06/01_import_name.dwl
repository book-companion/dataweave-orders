%dw 2.0
import orderTotal from orders::OrderMath
output application/json
---
{ id: payload.orderId, total: orderTotal(payload.items) }
