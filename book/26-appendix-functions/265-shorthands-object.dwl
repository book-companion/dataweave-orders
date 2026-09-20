%dw 2.0
output application/json
---
{
  renamed: payload.items[0] mapObject { (upper($$)): $ },
  positions: payload.items[0] mapObject { ($$ ++ "_" ++ $$$): $ },
  plucked: payload.items[0] pluck { key: $$, value: $, index: $$$ }
}
