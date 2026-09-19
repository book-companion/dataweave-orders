%dw 2.0
output application/xlsx
---
{ Items: payload.items map { sku: $.sku, qty: $.qty } }
