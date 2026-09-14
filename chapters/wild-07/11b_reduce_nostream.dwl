%dw 2.0
output application/json
---
{ revenue: payload reduce ((order, acc = 0) -> acc + order.total) }
