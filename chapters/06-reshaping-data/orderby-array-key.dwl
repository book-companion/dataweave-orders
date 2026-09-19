%dw 2.0
output application/json
---
payload orderBy (line) -> [line.category, -line.qty]
