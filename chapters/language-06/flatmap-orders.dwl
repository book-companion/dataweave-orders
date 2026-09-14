%dw 2.0
output application/json
---
{
  mapped:  (payload map (order) -> order.items) map sizeOf($),
  flat:    payload flatMap (order) -> order.items map (item) -> { orderId: order.orderId, sku: item.sku },
  same:    flatten(payload map (order) -> order.items) == (payload flatMap (order) -> order.items)
}
