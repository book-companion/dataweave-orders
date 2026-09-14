%dw 2.0
import * from dw::core::Arrays
output application/json
var items = payload.items
---
{
  sumOfNothing:  [] sumBy (i) -> i.price,
  countOfNothing: [] countBy (i) -> true,
  allPositive:   items every (i) -> i.qty > 0,
  anyBulk:       items some (i) -> i.qty >= 10,
  firstBulk:     items firstWith (i) -> i.qty >= 10,
  noneFound:     items firstWith (i) -> i.qty > 100,
  pages:         items divideBy 2,
  skuIndex:      items indexOf { sku: "PAD-22", price: 6.0, qty: 2 },
  head:          items take 1,
  rest:          items drop 1
}
