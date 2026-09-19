%dw 2.0
output application/json
---
payload map (line) -> {
  sku: line.sku,
  (single: true) if (not (line.qty >= 3))
}
