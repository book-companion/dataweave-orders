%dw 2.0
output application/json
fun lineTotal(price, qty) = price * qty
---
{ pens: lineTotal(2.5, 4), pads: lineTotal(6, 2) }
