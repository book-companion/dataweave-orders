%dw 2.0
import lineTotal from orders::Untyped
import lineTotal from orders::Pricing
output application/json
---
lineTotal(payload.items[0])
