%dw 2.0
output application/json
---
{
  multiply: payload.items[0].price * payload.items[0].qty,
  concat: payload.items[0].price ++ payload.items[0].qty,
  compareRaw: payload.items[0].price == 2.5,
  compareCoerced: (payload.items[0].price as Number) == 2.5,
  greater: payload.items[0].qty > 3
}
