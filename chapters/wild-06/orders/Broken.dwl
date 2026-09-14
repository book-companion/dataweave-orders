%dw 2.0
output application/json
fun lineTotal(item) = item.price * item.qty
---
lineTotal({ price: 1, qty: 1 })
