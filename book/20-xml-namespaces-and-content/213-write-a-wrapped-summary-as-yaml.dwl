%dw 2.0
output application/yaml
---
{
  summary: {
    id: payload.orderId,
    buyer: payload.customer,
    lineCount: sizeOf(payload.items)
  }
}
