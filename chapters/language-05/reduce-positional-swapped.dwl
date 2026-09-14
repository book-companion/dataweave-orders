%dw 2.0
output application/json
---
{
  accThenItem: payload.items.sku reduce ($$ ++ "," ++ $),
  itemThenAcc: payload.items.sku reduce ($ ++ "," ++ $$)
}
