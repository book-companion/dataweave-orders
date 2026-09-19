%dw 2.0
output application/json
---
{ attrs: payload.customer.@, one: payload.customer.@tier }
