%dw 2.0
output application/json
---
{
  chained: payload.coupon default payload.promoCode default "NONE",
  withIf:  if (payload.coupon != null) payload.coupon else "NONE"
}
