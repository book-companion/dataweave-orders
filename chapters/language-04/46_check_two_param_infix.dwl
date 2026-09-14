%dw 2.0
output application/json
fun lineTotal(item, index) = item.price * item.qty
---
payload.items map lineTotal($)
