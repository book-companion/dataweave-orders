%dw 2.0
import mergeWith, nameSet, entrySet from dw::core::Objects
output application/json
var defaults = { currency: "USD", giftWrap: false }
var order    = { id: "A-1001", giftWrap: true }
---
{
  merged:  defaults mergeWith order,
  keys:    nameSet(order),
  entries: entrySet(order)
}
