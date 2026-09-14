%dw 2.0
ns ord http://shipping.acme.com/orders
output application/json
---
payload.ord#orderBatch.*ord#order map (order) -> {
  id: order.@id,
  note: order.ord#note,
  noteType: typeOf(order.ord#note),
  customer: order.ord#customer,
  tier: order.ord#customer.@tier,
  firstPrice: order.*ord#line[0].ord#price,
  firstCurrency: order.*ord#line[0].ord#price.@currency,
  priceType: typeOf(order.*ord#line[0].ord#price)
}
