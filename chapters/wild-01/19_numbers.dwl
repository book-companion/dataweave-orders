%dw 2.0
output application/json
---
{
  literals: [1, 2.50, 6.0, 1E3, 10000000000000000000000, 0.1 + 0.2],
  types:    [1, 2.50, 10000000000000000000000, "7" as Number] map (typeOf($) as String),
  fromPayload: payload.items map $.price
}
