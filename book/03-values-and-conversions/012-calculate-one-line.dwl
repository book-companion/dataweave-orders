%dw 2.0
output application/json
---
{ sku: payload.sku, lineTotal: payload.price * payload.qty }
