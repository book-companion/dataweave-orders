%dw 2.0
input payload application/json
output application/json indent=false
---
{ id: payload.orderId, skus: payload.items.*sku }
