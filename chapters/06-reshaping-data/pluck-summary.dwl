%dw 2.0
output application/json
---
(payload groupBy (line) -> line.category) pluck (lines, category) -> {
  category: category,
  lineCount: sizeOf(lines)
}
