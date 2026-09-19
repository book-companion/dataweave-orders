%dw 2.0
output application/json
import * from Orders
var taxRate = 0.20
---
{ local: taxRate, viaModule: withTax(100) }
