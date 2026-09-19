%dw 2.0
output application/json
---
{
  orderId: payload.orderId,
  total: payload.items reduce (item, acc = 0) -> acc + (item.price * item.qty)
}
