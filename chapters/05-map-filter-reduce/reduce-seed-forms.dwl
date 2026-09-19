%dw 2.0
output application/json
---
{
  seeded:   [10, 20, 30] reduce (item, acc = 0) -> acc + item,
  unseeded: [10, 20, 30] reduce (item, acc) -> acc + item,
  emptySeeded:   [] reduce (item, acc = 0) -> acc + item,
  emptyUnseeded: [] reduce (item, acc) -> acc + item
}
