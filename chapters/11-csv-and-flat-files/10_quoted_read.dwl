%dw 2.0
output application/json
---
payload map { sku: $.sku, name: $.name }
