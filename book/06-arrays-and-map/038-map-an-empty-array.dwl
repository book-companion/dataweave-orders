%dw 2.0
output application/json
---
[] map (item) -> { sku: item.sku }
