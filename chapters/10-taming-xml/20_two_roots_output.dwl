%dw 2.0
output application/xml
---
{
  id: payload.order.@id,
  customer: payload.order.customer
}
