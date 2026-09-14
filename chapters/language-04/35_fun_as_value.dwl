%dw 2.0
output application/json
fun lineTotal(item) = item.price * item.qty
var alias = lineTotal
---
{ typeName: typeOf(lineTotal), viaAlias: alias(payload.items[0]), prefix: map(payload.items, lineTotal) }
