%dw 2.0
output application/json
---
payload map {
  sku: $.sku,
  name: $.name,
  qty: $.qty as Number,
  lineTotal: ($.qty as Number) * ($.price as Number)
}
