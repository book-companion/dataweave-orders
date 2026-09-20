%dw 2.0
output application/json
import * from Orders
fun discounted(order, pct) = subtotal(order) * (1 - pct)
---
payload map (order) -> { orderId: order.orderId, total: withTax(discounted(order, 0.10)) }
