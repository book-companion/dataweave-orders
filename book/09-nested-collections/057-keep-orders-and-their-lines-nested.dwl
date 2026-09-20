%dw 2.0
output application/json
---
payload map (order) -> { orderId: order.orderId, lines: order.items map (item) -> { sku: item.sku, amount: item.price * item.qty } }
