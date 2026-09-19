%dw 2.0
output application/json
var lineTotal = (item) -> item.price * item.qty
---
payload.items map lineTotal
