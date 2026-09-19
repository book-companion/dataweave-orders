%dw 2.0
output application/json
---
(payload orderBy (line) -> -line.price) map { sku: $.sku, price: $.price }
