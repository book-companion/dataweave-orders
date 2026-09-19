%dw 2.0
output application/json
---
payload.items reduce (item, acc) -> acc ++ "," ++ item.sku
