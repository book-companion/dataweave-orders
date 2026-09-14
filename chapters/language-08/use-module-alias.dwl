%dw 2.0
output application/json
import Orders as O
---
payload map (order) -> { orderId: order.orderId, total: O::withTax(O::subtotal(order)) }
