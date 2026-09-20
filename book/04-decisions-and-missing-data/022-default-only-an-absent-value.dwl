%dw 2.0
output application/json
---
{ coupon: payload.coupon default "NONE", giftWrap: payload.giftWrap default false, notes: payload.notes default "no notes", zero: 0 default 5, flag: false default true }
