%dw 2.0
output application/json
fun lineTotal(price: Number, qty: Number): Number = price * qty
---
{ numbers: lineTotal(2.5, 4), text: lineTotal("2.50", "4") }
