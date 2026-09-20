%dw 2.0
import orderTotal from orders::OrderMath
output application/json
---
orderTotal([ { sku: "PEN-01", price: "2.50", qty: 4 } ])
