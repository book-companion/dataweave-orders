%dw 2.0
output application/json
---
{
  price: typeOf(payload.items[0].price),
  qty: typeOf(payload.items[0].qty),
  placed: typeOf(payload.placed)
}
