%dw 2.0
output application/json
---
{
  prices: payload..price,
  itemPrices: payload.items..price,
  names: payload..name
}
