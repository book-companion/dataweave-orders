%dw 2.0
ns ord http://shipping.acme.com/orders
output application/json
---
(payload.ord#orderBatch.*ord#order default []) map (order) -> {
  id: order.@id,
  skus: (order.*ord#line default []) map (line) -> line.ord#sku
}
