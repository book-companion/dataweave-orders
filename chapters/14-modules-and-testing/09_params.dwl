%dw 2.0
output application/json
---
{ id: payload.orderId, env: params.env, taxRate: params.taxRate as Number }
