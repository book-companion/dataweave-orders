%dw 2.0
import * from dw::core::Objects
output application/json
var defaults = { currency: "USD", giftWrap: false }
var order    = { id: "A-1001", giftWrap: true }
---
{
  reversed:   order mergeWith defaults,
  plusOp:     defaults ++ order,
  values:     valueSet(order),
  keyTypes:   keySet(order),
  hasId:      order someEntry (value, key) -> key ~= "id",
  allSet:     order everyEntry (value, key) -> value != null,
  pairs:      order divideBy 1,
  fromEntries: entrySet(order) map { ($.key): $.value }
}
