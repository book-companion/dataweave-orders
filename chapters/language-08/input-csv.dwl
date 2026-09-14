%dw 2.0
input payload application/csv
output application/json
---
payload map (row) -> { sku: row.sku, qty: row.qty as Number, rawType: typeOf(row.qty) }
