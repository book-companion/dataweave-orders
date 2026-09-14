%dw 2.0
ns ord http://shipping.acme.com/orders
output application/json
---
payload.ord#orderBatch.*ord#order map (order) -> {
  id: order.@id,
  glued: order.*ord#line[0].ord#price ++ order.*ord#line[0].ord#qty,
  multiplied: order.*ord#line[0].ord#price * order.*ord#line[0].ord#qty
}
