%dw 2.0
output application/json
---
payload map (item) -> { sku: item.sku, amount: item.price * item.qty }
