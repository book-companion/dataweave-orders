%dw 2.0
output application/json
import * from Orders
import * from Pricing
---
withTax(100)
