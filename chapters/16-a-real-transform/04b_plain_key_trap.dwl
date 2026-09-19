%dw 2.0
ns ord http://shipping.acme.com/orders
import money from orders::Feed
import sumBy from dw::core::Arrays
output application/json
---
(flatten(payload.ord#orderBatch.*ord#order.*ord#line) groupBy (line) -> line.ord#category)
  mapObject (lines, category) -> { category: sizeOf(lines) }
