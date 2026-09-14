%dw 2.0
ns ord http://shipping.acme.com/orders
import money from orders::Feed
import sumBy from dw::core::Arrays
output application/json
---
(payload.ord#orderBatch.*ord#order groupBy (o) -> o.ord#customer.@tier)
  mapObject (orders, tier) -> {
    (tier): {
      orders: sizeOf(orders),
      revenue: flatten(orders.*ord#line) sumBy (l) -> money(l.ord#price) * (l.ord#qty as Number)
    }
  }
