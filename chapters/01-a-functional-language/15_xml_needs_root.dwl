%dw 2.0
output application/xml
---
{
  id: payload.orderId,
  buyer: payload.customer
}
