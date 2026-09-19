%dw 2.0
output application/json
---
read(payload, "application/csv", { header: false }) map {
  sku: $.column_0,
  qty: $.column_2 as Number
}
