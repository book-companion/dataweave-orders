%dw 2.0
import mergeWith from dw::core::Objects
output application/json
var defaults = { currency: "USD", coupon: "NONE" }
---
{
  merged:   defaults mergeWith { coupon: payload.coupon },
  guarded:  defaults mergeWith { coupon: payload.coupon default "NONE" },
  stripped: defaults mergeWith ({ coupon: payload.coupon } filterObject (v) -> v != null)
}
