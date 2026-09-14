%dw 2.0
ns ord http://shipping.acme.com/orders
import parseDate, money from orders::Feed
import sumBy from dw::core::Arrays
output application/json
var orders = payload.ord#orderBatch.*ord#order
fun lineTotal(line) = money(line.ord#price) * (line.ord#qty as Number)
---
{
  batchId: payload.ord#orderBatch.@batchId,
  orders: orders map (order) -> {
    id: order.@id,
    lines: order.*ord#line map (line) -> { sku: line.ord#sku },
    orderTotal: order.*ord#line sumBy (line) -> lineTotal(line)
  },
  revenueByCategory:
    (flatten(orders.*ord#line) groupBy (line) -> line.ord#category)
      mapObject (lines, category) -> { (category): lines sumBy (line) -> lineTotal(line) },
  batchTotal: flatten(orders.*ord#line) sumBy (line) -> lineTotal(line)
}
