%dw 2.0
output application/json
---
{
  count: sizeOf(payload.order.*item),
  skus:  payload.order.*item map $.@sku
}
