%dw 2.0
output application/csv separator="\t"
---
payload.items map { sku: $.sku, qty: $.qty, lineTotal: $.qty * $.price }
