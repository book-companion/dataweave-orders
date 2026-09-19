%dw 2.0
output application/json
---
{ coupon: payload.coupon as Number }
