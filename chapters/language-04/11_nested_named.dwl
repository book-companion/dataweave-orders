%dw 2.0
output application/json
---
payload.items map (item) -> { sku: item.sku, multiples: [1, 2] map (item.qty * $) }
