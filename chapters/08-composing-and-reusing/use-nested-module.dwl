%dw 2.0
output application/json
import * from modules::Orders
---
payload map (order) -> { orderId: order.orderId, total: withTax(subtotal(order)) }
