%dw 2.0
output application/json
fun classify(order) = do {
  var items    = order.items default []
  var subtotal = sum(items map (i) -> i.price * i.qty)
  var shipping = if (subtotal >= 20) 0 else 4.99
  ---
  {
    orderId:  order.orderId,
    subtotal: subtotal,
    shipping: shipping,
    total:    subtotal + shipping,
    tier:     subtotal match {
      case s if (s >= 30) -> "gold"
      case s if (s > 0)   -> "standard"
      else -> "empty cart"
    }
  }
}
---
payload map classify($)
