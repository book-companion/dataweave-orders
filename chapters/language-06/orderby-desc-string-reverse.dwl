%dw 2.0
output application/json
---
reverse(payload orderBy (line) -> line.name)
