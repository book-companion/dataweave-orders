%dw 2.0
output application/csv
var names = ["sku", "name", "qty", "price"]
---
read(payload, "application/csv", { header: false }) map (row) ->
  (row pluck ((value, key, index) -> { (names[index]): value })) reduce ($$ ++ $)
