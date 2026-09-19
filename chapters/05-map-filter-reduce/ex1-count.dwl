%dw 2.0
output application/json
---
{
  viaFilter: sizeOf(payload.items filter (item) -> item.qty >= 4),
  viaReduce: payload.items reduce (item, acc = 0) -> if (item.qty >= 4) acc + 1 else acc
}
