%dw 2.0
output application/csv quote="'", escape="\\"
---
payload map { sku: $.sku, name: $.name }
