%dw 2.0
output application/json
---
{
  byHand: [[1, 2], [3, 4], [5]] reduce (item, acc = []) -> acc ++ item,
  stock:  flatten([[1, 2], [3, 4], [5]])
}
