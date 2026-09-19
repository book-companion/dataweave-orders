%dw 2.0
output application/json
---
read(payload, "application/csv", { separator: "\t" }) map { sku: $.sku, qty: $.qty as Number }
