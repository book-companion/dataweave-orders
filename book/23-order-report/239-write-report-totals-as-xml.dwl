%dw 2.0
ns ord http://shipping.acme.com/orders
import normalizeBatch, report from orders::Feed
output application/xml
var result = report(normalizeBatch(payload.ord#orderBatch))
---
report: {
  (result.orders map (order) -> {
    order @(id: order.id, placedAt: order.placedAt): order.orderTotal
  })
}
