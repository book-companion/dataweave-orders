%dw 2.0
output application/json
fun receipt(order) = do {
  var lines = order.items map (i) -> i ++ { total: i.price * i.qty }
  var sub   = sum(lines.total)
  ---
  {
    orderId:  order.orderId,
    lines:    lines,
    subtotal: sub,
    tax:      sub * 0.08
  }
}
---
payload map receipt($)
