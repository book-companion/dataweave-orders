%dw 2.0
output application/json
---
{
  units: sum(payload.items.qty),
  starUnits: sum(payload.items.*qty),
  everyQty: payload..qty
}
