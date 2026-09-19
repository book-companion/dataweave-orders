%dw 2.0
output application/json
---
(payload orderBy (line) -> line.name)[-1 to 0] map $.name
