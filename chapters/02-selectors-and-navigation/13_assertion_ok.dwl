%dw 2.0
output application/json
---
{ email: payload.customer.email! }
