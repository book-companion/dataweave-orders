%dw 2.0
ns ord http://acme.com/orders
output application/json
---
{
  orderId:  payload.ord#order.@id,
  customer: payload.ord#order.ord#customer,
  currency: payload.ord#order.ord#total.@currency,
  total:    payload.ord#order.ord#total as Number,
  lines:    payload.ord#order.*ord#item map {
    sku:  $.@sku,
    qty:  $.@qty as Number,
    name: $
  }
}
