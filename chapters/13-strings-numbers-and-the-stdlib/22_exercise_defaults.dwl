%dw 2.0
import mergeWith from dw::core::Objects
import sumBy, partition from dw::core::Arrays
output application/json
var defaults = { currency: "USD", giftWrap: false, coupon: "NONE" }
---
do {
  var merged = defaults mergeWith (payload - "items" - "tags")
  var split  = payload.items partition (i) -> i.qty >= 4
  ---
  {
    order:   merged,
    bulk:    split.success.sku,
    single:  split.failure.sku,
    bulkRevenue: split.success sumBy (i) -> i.price * i.qty
  }
}
