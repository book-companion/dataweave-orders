%dw 2.0
output application/json
---
{
  coupon:     payload.order.coupon,
  couponType: typeOf(payload.order.coupon) as String,
  isNull:     payload.order.coupon == null,
  isEmpty:    payload.order.coupon == "",
  missing:    payload.order.giftWrap
}
