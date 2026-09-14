%dw 2.0
ns ord http://shipping.acme.com/orders
import money from orders::Feed
output application/json
---
payload.ord#orderBatch.*ord#order map (order) -> {
  id: order.@id,
  orderTotal: order.*ord#line sumBy (line) -> money(line.ord#price) * (line.ord#qty as Number)
}
