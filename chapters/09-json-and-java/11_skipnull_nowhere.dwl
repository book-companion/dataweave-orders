%dw 2.0
output application/json skipNullOn="nowhere"
---
{ orderId: payload.orderId, coupon: payload.coupon, tags: payload.tags }
