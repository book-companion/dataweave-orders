%dw 2.0
ns ord http://shipping.acme.com/orders
import normalizeBatch, receipt from orders::Feed
output application/json
var orders = normalizeBatch(payload.ord#orderBatch).orders
var tiers = orders groupBy (order) -> order.tier
---
tiers mapObject (orders, tier) -> {
  (tier): { orders: sizeOf(orders), revenue: sum(orders map (order) -> receipt(order).orderTotal) }
}
