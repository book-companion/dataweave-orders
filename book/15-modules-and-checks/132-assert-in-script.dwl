%dw 2.0
import orderTotal from orders::OrderMath
output application/json
var cases = [
  { name: "sums the lines",   items: [ { sku: "PEN-01", price: 2.5, qty: 4 }, { sku: "PAD-22", price: 6.0, qty: 2 } ], want: 22.0 },
  { name: "empty order is 0", items: [],                                                                             want: 0 },
  { name: "deliberately wrong", items: [ { sku: "CLP-08", price: 1.0, qty: 10 } ],                                want: 11 }
]
---
cases map (c) -> do {
  var got = orderTotal(c.items)
  ---
  { name: c.name, pass: got == c.want, got: got, want: c.want }
}
