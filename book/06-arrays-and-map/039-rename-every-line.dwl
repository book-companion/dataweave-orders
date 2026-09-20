%dw 2.0
output application/json
---
payload map (item) -> { productCode: item.sku, quantity: item.qty }
