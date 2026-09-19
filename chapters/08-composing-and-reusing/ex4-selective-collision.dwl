%dw 2.0
output application/json
import withTax from Orders
import withTax from Pricing
---
withTax(100)
