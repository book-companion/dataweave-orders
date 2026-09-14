%dw 2.0
ns ord http://acme.com/order
output application/json
---
{ customer: payload.ord#order.ord#customer }
