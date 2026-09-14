%dw 2.0
ns ord http://shipping.acme.com/orders
import parseDate, money from orders::Feed
import sumBy from dw::core::Arrays
output application/json
---
payload.ord#orderBatch.*ord#order map (order) -> {
  id: order.@id,
  placedAt: parseDate(order.ord#placedAt) as String { format: "yyyy-MM-dd" },
  customer: order.ord#customer,
  (vip: true) if (order.ord#customer.@tier == "gold"),
  lines: order.*ord#line map (line) -> {
    sku: line.ord#sku,
    category: line.ord#category,
    price: money(line.ord#price),
    qty: line.ord#qty as Number,
    lineTotal: money(line.ord#price) * (line.ord#qty as Number)
  },
  orderTotal: order.*ord#line sumBy (line) -> money(line.ord#price) * (line.ord#qty as Number)
}
