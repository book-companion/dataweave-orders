%dw 2.0
output application/json
---
(payload groupBy (line) -> line.orderId) pluck (lines, orderId) -> {
  orderId: orderId,
  units: sum(lines.qty),
  skus: lines.sku
}
