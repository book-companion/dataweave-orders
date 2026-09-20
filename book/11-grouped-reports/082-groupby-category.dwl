%dw 2.0
output application/json
---
payload groupBy (line) -> line.category
