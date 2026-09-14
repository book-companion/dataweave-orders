%dw 2.0
output application/json
fun lineTotal(item, index) = item.price * item.qty
---
{ infix: payload.items map lineTotal($, $$), prefix: map(payload.items, lineTotal) }
