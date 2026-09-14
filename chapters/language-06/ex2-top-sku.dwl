%dw 2.0
output application/json
---
(((payload groupBy (line) -> line.sku)
  pluck (lines, sku) -> { sku: sku, revenue: sum(lines map (l) -> l.price * l.qty) })
  orderBy (row) -> -row.revenue)[0]
