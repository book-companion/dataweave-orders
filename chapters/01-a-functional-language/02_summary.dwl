%dw 2.0
output application/json
---
{
  id: payload.orderId,
  buyer: payload.customer,
  lineCount: sizeOf(payload.items)
}
