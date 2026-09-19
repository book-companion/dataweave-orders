%dw 2.0
output application/json
import subtotal, withTax from Orders
---
payload map (order) -> { orderId: order.orderId, total: withTax(subtotal(order)) }
