%dw 2.0
output application/xml
---
{
  order: {
    id: payload.orderId,
    customer: payload.customer,
    total: sum(payload.items map ($.price * $.qty))
  }
}
