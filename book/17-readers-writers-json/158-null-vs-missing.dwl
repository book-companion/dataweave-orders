%dw 2.0
output application/json
---
{
  coupon:  payload.coupon,
  missing: payload.giftWrap,
  couponIsNull:  payload.coupon == null,
  missingIsNull: payload.giftWrap == null,
  keys: keysOf(payload) map ($ as String)
}
