%dw 2.0
output application/json
var byCategory = payload groupBy (line) -> line.category
---
byCategory mapObject (lines, category) -> {
  (category): sum(lines map (l) -> l.price * l.qty)
}
