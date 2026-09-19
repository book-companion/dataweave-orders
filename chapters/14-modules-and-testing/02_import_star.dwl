%dw 2.0
import * from orders::OrderMath
output application/json
---
{ id: payload.orderId, lines: payload.items map lineTotal($), total: orderTotal(payload.items) }
