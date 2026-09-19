%dw 2.0
output application/json
fun lineTotal(item) = item.price * item.qty
fun discountedBy(price, rate) = price * (1 - rate)
---
{
  infix: payload.items map lineTotal($),
  prefix: map(payload.items, (item) -> lineTotal(item)),
  ownInfix: 20 discountedBy 0.1,
  ownPrefix: discountedBy(20, 0.1)
}
