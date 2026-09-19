%dw 2.0
output application/json
---
{
  asBoolean: payload.items[0].sku matches /^[A-Z]{3}-\d{2}$/,
  asGroups:  payload.items[0].sku match /^([A-Z]{3})-(\d{2})$/
}
