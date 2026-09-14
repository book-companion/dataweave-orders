%dw 2.0
output application/json
---
{
  couponLabel: unless (payload.coupon == null) "coupon applied" else "no coupon",
  sameWithIf:  if (payload.coupon == null) "no coupon" else "coupon applied"
}
