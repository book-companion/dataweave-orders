%dw 2.0
import orderTotal from orders::OrderMath
import fail from dw::Runtime
output application/json
var cases = [
  { name: "sums the lines",     items: [ { sku: "PEN-01", price: 2.5, qty: 4 } ], want: 10 },
  { name: "deliberately wrong", items: [ { sku: "CLP-08", price: 1.0, qty: 10 } ], want: 11 }
]
---
cases map (c) -> do {
  var got = orderTotal(c.items)
  ---
  if (got == c.want) { name: c.name, pass: true }
  else fail(c.name ++ ": expected " ++ (c.want as String) ++ ", got " ++ (got as String))
}
