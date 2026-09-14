%dw 2.0
output application/json
---
payload map (order) -> { id: order.orderId, buyer: order.customer, total: order.total }
