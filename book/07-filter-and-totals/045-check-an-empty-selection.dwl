%dw 2.0
output application/json
var selected = payload.items filter (item) -> item.qty >= 100
---
{ count: sizeOf(selected), total: sum(selected map (item) -> item.price * item.qty) }
