%dw 2.0
output application/json
---
{
  exact: payload.items[0 to 2].sku,
  oneTooFar: payload.items[0 to 3].sku,
  startInside: payload.items[2 to 5].sku,
  single: payload.items[1 to 1].sku
}
