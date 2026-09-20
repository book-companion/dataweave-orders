%dw 2.0
output application/json skipNulls=true
---
{ orderId: payload.orderId, coupon: payload.coupon }
