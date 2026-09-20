%dw 2.0
output application/json
---
{ correct: payload.customer.name, misspelled: payload.customer.nmae, absent: payload.coupon }
