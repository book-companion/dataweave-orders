%dw 2.0
output application/json
type LineItem = { sku: String, price: Number, qty: Number }
---
{ item: { sku: "PEN-01", price: "2.50", qty: 4 } as LineItem }
