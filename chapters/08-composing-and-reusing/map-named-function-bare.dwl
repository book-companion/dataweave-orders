%dw 2.0
output application/json
fun lineTotal(item) = item.price * item.qty
---
payload[0].items map lineTotal
