%dw 2.0
output application/json
---
{ notes: if (isEmpty(payload.notes)) "no notes" else payload.notes, couponPresent: payload.coupon?, giftWrapPresent: payload.giftWrap? }
