%dw 2.0
output application/json
fun lineTotal(price: Number, qty: Number): Number = price * qty
---
{ total: lineTotal(payload.items[0].price, payload.items[0].qty) }
