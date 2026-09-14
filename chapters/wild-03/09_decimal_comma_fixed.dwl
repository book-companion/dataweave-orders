%dw 2.0
output application/json
---
read(payload, "application/csv", { separator: ";" }) map {
  sku:   $.sku,
  price: ($.price replace "," with ".") as Number
}
