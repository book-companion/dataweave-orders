%dw 2.0
output application/yaml
---
{
  id: payload.orderId,
  buyer: payload.customer,
  lineCount: sizeOf(payload.items)
}
