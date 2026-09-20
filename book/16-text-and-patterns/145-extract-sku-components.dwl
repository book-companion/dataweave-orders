%dw 2.0
import substringBefore, substringAfter from dw::core::Strings
output application/json
---
payload.items map (item) -> {
  family: substringBefore(item.sku, "-"),
  number: substringAfter(item.sku, "-") as Number,
  parts:  item.sku match /([A-Z]+)-(\d+)/
}
