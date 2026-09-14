%dw 2.0
import * from orders::Untyped
import * from orders::Pricing
output application/json
---
lineTotal(payload.items[0])
