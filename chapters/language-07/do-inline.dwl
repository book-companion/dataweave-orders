%dw 2.0
output application/json
---
{
  orderId: payload.orderId,
  shipping: do {
    var subtotal = sum(payload.items map (i) -> i.price * i.qty)
    ---
    if (subtotal >= 20) "free" else "4.99"
  }
}
