%dw 2.0
import * from dw::core::Strings
output application/json
---
{
  capNull:   capitalize(payload.coupon),
  afterNull: substringAfter(payload.coupon, ":"),
  padNull:   payload.coupon leftPad 6,
  blankNull: isBlank(payload.coupon)
}
