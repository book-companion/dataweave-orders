%dw 2.0
output application/xml
---
{ order: { coupon: null, note: "", giftWrap: payload.order.giftWrap } }
