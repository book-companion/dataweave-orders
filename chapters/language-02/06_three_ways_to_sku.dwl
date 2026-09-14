%dw 2.0
output application/json
---
{
  dot: payload.items.sku,
  star: payload.items.*sku,
  descend: payload..sku
}
