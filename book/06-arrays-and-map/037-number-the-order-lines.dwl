%dw 2.0
output application/json
---
payload map (item, index) -> { line: index + 1, sku: item.sku }
