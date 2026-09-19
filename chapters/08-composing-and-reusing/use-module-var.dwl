%dw 2.0
output application/json
import * from Orders
---
{ rate: taxRate, total: withTax(subtotal(payload[0])) }
