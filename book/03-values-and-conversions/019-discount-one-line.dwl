%dw 2.0
output application/json
var lineTotal = payload.price * payload.qty
---
{ lineTotal: lineTotal, discounted: lineTotal * 0.9 }
