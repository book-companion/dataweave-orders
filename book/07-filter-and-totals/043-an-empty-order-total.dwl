%dw 2.0
output application/json
var items = payload.items default []
var amounts = items map (item) -> item.price * item.qty
---
{ count: sizeOf(items), amounts: amounts, total: sum(amounts) }
