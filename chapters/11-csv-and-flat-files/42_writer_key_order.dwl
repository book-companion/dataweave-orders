%dw 2.0
output application/csv
---
[
  { sku: "PEN-01", qty: 4 },
  { qty: 2, sku: "PAD-22" },
  { sku: "CLP-08", qty: 10, note: "bulk" },
  { sku: "PEN-01" }
]
