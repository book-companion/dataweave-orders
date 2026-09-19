%dw 2.0
output application/json
var total = 0
---
payload.items map (item) -> total = total + item.price * item.qty
