%dw 2.0
import lineTotal from orders::OrderMath
import lineTotal as taxedLineTotal from orders::Pricing
output application/json
---
{ net: lineTotal(payload.items[0]), gross: taxedLineTotal(payload.items[0]) }
