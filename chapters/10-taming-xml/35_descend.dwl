%dw 2.0
output application/json
---
{
  fromRoot:   payload..item,
  fromOrder:  payload.order..item,
  starItems:  payload.order.*item,
  descendAttr: payload..@sku,
  starAttr:   payload.order.*item.@sku
}
