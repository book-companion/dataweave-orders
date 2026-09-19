%dw 2.0
output application/json
---
payload map (row) -> { sku: row.sku, qty: row.qty as Number }
