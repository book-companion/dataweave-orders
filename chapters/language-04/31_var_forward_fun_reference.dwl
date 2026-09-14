%dw 2.0
output application/json
var totals = payload.items map lineTotal($)
fun lineTotal(item) = item.price * item.qty
---
totals
