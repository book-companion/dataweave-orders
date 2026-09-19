%dw 2.0
output application/json
---
payload map (line) -> unless (line.qty >= 3) line.sku ++ " (single)" else line.sku
