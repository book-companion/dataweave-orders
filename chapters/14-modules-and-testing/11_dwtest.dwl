%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts
import orderTotal from orders::OrderMath
---
"OrderMath" describedBy [
  "sums the line items" in do {
    orderTotal([ { sku: "PEN-01", price: 2.5, qty: 4 }, { sku: "PAD-22", price: 6.0, qty: 2 } ]) must equalTo(22.0)
  }
]
