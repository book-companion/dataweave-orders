%dw 2.0
output application/json
---
payload map (line) -> {
  sku: line.sku,
  (single: true) unless (line.qty >= 3)
}
