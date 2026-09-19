%dw 2.0
output application/json
---
{
  id: payload.orderId,
  email: payload.customer.email,
  first: payload.items[0].sku,
  last: payload.items[-1].sku
}
