%dw 2.0
output application/json
---
(payload orderBy (line) -> line.qty) map (line) -> { sku: line.sku, qty: line.qty }
