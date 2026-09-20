%dw 2.0
output application/json
fun lineTotal(price: Number, qty: Number): Number = price * qty
---
{ total: lineTotal(payload.customer, payload.items[0].qty) }
