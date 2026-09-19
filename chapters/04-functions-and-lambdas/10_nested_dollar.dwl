%dw 2.0
output application/json
---
payload.items map { sku: $.sku, multiples: [1, 2] map ($ * $$) }
