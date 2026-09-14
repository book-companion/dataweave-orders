%dw 2.0
output application/json
---
{
  couponPresent:   payload.coupon?,
  giftWrapPresent: payload.giftWrap?,
  hasKey:          keysOf(payload) contains "giftWrap"
}
