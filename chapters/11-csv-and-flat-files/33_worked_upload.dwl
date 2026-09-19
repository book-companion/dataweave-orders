%dw 2.0
output application/json
---
read(payload, "application/csv", { separator: ";" })
  map ($ mapObject { (trim($$)): trim($) })
  map (row) -> {
    sku:       row.sku,
    name:      row.name,
    qty:       row.qty as Number,
    unitPrice: row.unit_price as Number
  }
