%dw 2.0
output application/csv
---
payload.items map { sku: $.sku, dims: { w: 10, h: 20 } }
