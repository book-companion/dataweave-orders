%dw 2.0
import lineTotal from orders::Broken
output application/json
---
lineTotal(payload.items[0])
