%dw 2.0
output application/json
---
{
  id: payload.orderId,
  email: payload.customer.email default "unknown"
}
