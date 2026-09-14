%dw 2.0
output application/json
---
{
  second:   payload.order.*item[1],
  skus:     payload..sku,
  names:    payload..item,
  count:    sizeOf(payload.order.*item)
}
