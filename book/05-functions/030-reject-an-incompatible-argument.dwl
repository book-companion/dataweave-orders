%dw 2.0
output application/json
fun lineTotal(price: Number, qty: Number): Number = price * qty
---
lineTotal("many", 4)
