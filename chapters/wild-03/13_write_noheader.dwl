%dw 2.0
output application/csv header=false
---
payload map { sku: $.sku, qty: $.qty }
