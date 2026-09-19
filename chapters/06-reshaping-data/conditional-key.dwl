%dw 2.0
output application/json
---
payload map (line) -> {
  sku: line.sku,
  qty: line.qty,
  (bulk: true) if (line.qty >= 3)
}
