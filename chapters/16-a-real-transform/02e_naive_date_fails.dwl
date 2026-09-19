%dw 2.0
ns ord http://shipping.acme.com/orders
output application/json
---
payload.ord#orderBatch.*ord#order map (order) -> {
  id: order.@id,
  placedAt: order.ord#placedAt as Date
}
