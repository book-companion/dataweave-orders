%dw 2.0
ns ord http://shipping.acme.com/orders
output application/json
---
payload.ord#orderBatch.*ord#order map (order) -> {
  id: order.@id,
  lines: order.*ord#line map (line) -> {
    sku: line.ord#sku,
    category: line.ord#category
  }
}
