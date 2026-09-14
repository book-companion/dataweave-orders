%dw 2.0
output application/yaml
---
{
  order: {
    id: payload.orderId,
    customer: payload.customer,
    total: sum(payload.items map ($.price * $.qty))
  }
}
