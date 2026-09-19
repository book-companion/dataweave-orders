%dw 2.0
output application/csv
---
payload flatMap (order) -> order.items map (item) -> {
  orderId: order.orderId, sku: item.sku, amount: item.price * item.qty
}
