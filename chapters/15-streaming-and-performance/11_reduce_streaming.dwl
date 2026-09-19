%dw 2.0
input payload application/json streaming=true
output application/json
---
{ revenue: payload reduce ((order, acc = 0) -> acc + order.total) }
