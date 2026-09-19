%dw 2.0
output application/json
fun itemAndIndex(item, index) = item.sku ++ "@" ++ index
---
{
  oneParam: payload.items map (item) -> item.sku,
  twoParams: payload.items map (item, index) -> itemAndIndex(item, index),
  viaShorthand: payload.items map itemAndIndex($, $$)
}
