%dw 2.0
output application/json
var groups = payload groupBy (line) -> line.category
var rows = groups pluck (lines, category) -> { category: category as String, revenue: sum(lines map (line) -> line.price * line.qty) }
---
rows orderBy (row) -> -row.revenue
