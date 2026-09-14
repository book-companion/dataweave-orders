%dw 2.0
output application/json
---
{
  firstGroupOfNothing: ("nope" match /(\d+)/)[1],
  guarded: ("nope" match /(\d+)/)[1] default "n/a",
  skuNumbers: payload.items.sku map (($ match /[A-Z]+-(\d+)/)[1] as Number)
}
