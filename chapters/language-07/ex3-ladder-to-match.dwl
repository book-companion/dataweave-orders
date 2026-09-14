%dw 2.0
output application/json
fun shipping(order) = do {
  var subtotal = sum((order.items default []) map (i) -> i.price * i.qty)
  ---
  subtotal match {
    case s if (s == 0)  -> null
    case s if (s >= 30) -> 0
    case s if (s >= 20) -> 2.99
    else -> 4.99
  }
}
---
payload map { orderId: $.orderId, shipping: shipping($) }
