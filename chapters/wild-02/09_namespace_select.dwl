%dw 2.0
ns ord http://acme.com/orders
output application/json
---
{
  total:      payload.ord#order.ord#total,
  unprefixed: payload.order.total,
  customer:   payload.ord#order.ord#customer
}
