%dw 2.0
output application/json
---
{ sku: payload.sku, price: payload.price as Number, qty: payload.qty as Number, lineTotal: (payload.price as Number) * (payload.qty as Number) }
