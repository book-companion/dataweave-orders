%dw 2.0
output application/json
---
payload.order.item map { sku: $.@sku, name: $ }
