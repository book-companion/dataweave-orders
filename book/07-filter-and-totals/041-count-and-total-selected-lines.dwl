%dw 2.0
output application/json
var bulk = payload.items filter (item) -> item.qty >= 4
var amounts = bulk map (item) -> item.price * item.qty
---
{ lineCount: sizeOf(bulk), amounts: amounts, total: sum(amounts) }
