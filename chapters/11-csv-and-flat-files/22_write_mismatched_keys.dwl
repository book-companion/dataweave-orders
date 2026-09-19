%dw 2.0
output application/csv
---
[
  { sku: "PEN-01", qty: 4 },
  { sku: "PAD-22", qty: 2, note: "gift" },
  { qty: 10, sku: "CLP-08" }
]
