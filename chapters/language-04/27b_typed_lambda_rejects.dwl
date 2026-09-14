%dw 2.0
output application/json
var lineTotal = (item: Object): Number -> item.price * item.qty
---
lineTotal(payload.items)
