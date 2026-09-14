%dw 2.0
output application/xml
---
{
  summary: {
    id: payload.orderId,
    buyer: payload.customer,
    lineCount: sizeOf(payload.items)
  }
}
