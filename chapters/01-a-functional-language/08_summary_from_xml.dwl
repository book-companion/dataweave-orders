%dw 2.0
output application/json
---
{
  id: payload.order.orderId,
  buyer: payload.order.customer,
  lineCount: sizeOf(payload.order.items.*item)
}
