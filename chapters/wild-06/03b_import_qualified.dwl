%dw 2.0
import orders::OrderMath
output application/json
---
{ id: payload.orderId, total: OrderMath::orderTotal(payload.items) }
