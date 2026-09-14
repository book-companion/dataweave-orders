%dw 2.0
output application/json
---
{
  single: payload.order.item,
  many:   payload.order.*item,
  singleSku: payload.order.item.@sku,
  manySku:   payload.order.*item.@sku
}
