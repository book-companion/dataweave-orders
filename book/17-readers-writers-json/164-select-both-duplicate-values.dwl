%dw 2.0
output application/json
---
{ sku: payload.sku, skus: payload.*sku }
