%dw 2.0
output application/json
import * from Pricing
import * from Orders
---
withTax(100)
