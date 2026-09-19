%dw 2.0
output application/json
---
{
  currency: payload.order.@currency,
  allAttrs: payload.order.@,
  tier: payload.order.customer.@tier,
  skus: payload.order.items.*item.@sku,
  customer: payload.order.customer
}
