%dw 2.0
ns ord http://shipping.acme.com/orders
output application/json
---
payload.ord#orderBatch.*ord#order map (order) -> {
  id: order.@id,
  lineType: typeOf(order.ord#line),
  skus: order.ord#line.ord#sku
}
