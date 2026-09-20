%dw 2.0
import sumBy, countBy, partition from dw::core::Arrays
output application/json
var items = [
  { sku: "PEN-01", price: 2.5, qty: 4,  inStock: true },
  { sku: "PAD-22", price: 6.0, qty: 2,  inStock: false },
  { sku: "CLP-08", price: 1.0, qty: 10, inStock: true }
]
---
{
  revenue:   items sumBy (i) -> i.price * i.qty,
  backorder: items countBy (i) -> not i.inStock,
  split:     items partition (i) -> i.inStock
}
