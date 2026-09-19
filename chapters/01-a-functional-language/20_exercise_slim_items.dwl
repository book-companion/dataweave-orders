%dw 2.0
output application/json
---
{
  id: payload.orderId,
  skus: payload.items.sku,
  units: sum(payload.items.qty)
}
