%dw 2.0
output application/json
fun lineTotal(item) = item.price * item.qty
---
map(payload.items, (item) -> lineTotal(item))
