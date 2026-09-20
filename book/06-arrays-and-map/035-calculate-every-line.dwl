%dw 2.0
output application/json
fun lineTotal(price, qty) = price * qty
---
payload map (item) -> lineTotal(item.price, item.qty)
