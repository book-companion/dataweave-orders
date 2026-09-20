%dw 2.0
ns ord http://shipping.acme.com/orders
import normalizeBatch, report from orders::Feed
import fail from dw::Runtime
output application/json
var result = report(normalizeBatch(payload.ord#orderBatch))
var orderSum = sum(result.orders map (order) -> order.orderTotal)
var categorySum = sum(result.revenueByCategory pluck (amount) -> amount)
---
if (result.batchTotal == 71 and orderSum == 71 and categorySum == 71 and sizeOf(result.orders) == 3)
  { passed: true, batchTotal: result.batchTotal }
else fail("Report totals or order count changed")
