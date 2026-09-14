%dw 2.0
output application/json
import Orders
import Pricing
---
{ orders: Orders::withTax(100), pricing: Pricing::withTax(100) }
