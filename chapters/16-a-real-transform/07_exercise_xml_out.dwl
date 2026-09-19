%dw 2.0
ns ord http://shipping.acme.com/orders
import parseDate, money from orders::Feed
import sumBy from dw::core::Arrays
output application/xml
---
report: {
  (payload.ord#orderBatch.*ord#order map (order) -> {
    order @(id: order.@id, placedAt: parseDate(order.ord#placedAt) as String { format: "yyyy-MM-dd" }):
      order.*ord#line sumBy (line) -> money(line.ord#price) * (line.ord#qty as Number)
  })
}
