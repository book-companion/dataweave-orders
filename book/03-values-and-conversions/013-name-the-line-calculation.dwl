%dw 2.0
output application/json
var lineTotal = payload.price * payload.qty
---
{ sku: payload.sku, lineTotal: lineTotal, withDelivery: lineTotal + 4.99 }
