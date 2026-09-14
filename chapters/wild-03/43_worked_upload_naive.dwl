%dw 2.0
output application/json
---
read(payload, "application/csv", { separator: ";" }) map (row) -> {
  sku:  trim(row.sku),
  name: trim(row.name),
  qty:  trim(row.qty) as Number
}
