%dw 2.0
import * from orders::Pricing
import * from orders::OrderMath
output application/json
---
lineTotal(payload.items[0])
