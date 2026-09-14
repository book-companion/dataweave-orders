%dw 2.0
output application/json
---
payload.items map {
  sku: $.sku,
  lineTotal: ($.price as Number) * ($.qty as Number)
}
