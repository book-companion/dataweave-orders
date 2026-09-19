%dw 2.0
output application/json
fun subtotal(order) = do {
  var items = order.items default []
  ---
  sum(items map (i) -> i.price * i.qty)
}
---
{ total: subtotal(payload), count: sizeOf(items) }
