%dw 2.0
output application/json
---
((payload groupBy (line) -> line.category)
  pluck (lines, category) -> {
    category: category,
    revenue: sum(lines map (l) -> l.price * l.qty),
    (topSeller: true) if (sizeOf(lines) >= 3)
  })
  orderBy (row) -> -row.revenue
