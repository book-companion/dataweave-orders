%dw 2.0
output application/json
---
{
  orderId: payload.orderId,
  total: payload.items reduce (item, acc) -> acc + (item.price * item.qty)
}
