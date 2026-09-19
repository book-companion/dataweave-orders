%dw 2.0
output application/csv
---
payload map (order) -> { orderId: order.orderId, items: order.items }
