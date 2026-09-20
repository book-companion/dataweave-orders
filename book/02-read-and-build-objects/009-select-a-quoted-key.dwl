%dw 2.0
output application/json
---
{ method: payload."delivery-method", email: payload.customer["email"] }
