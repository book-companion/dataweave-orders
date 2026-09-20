%dw 2.0
output application/json
---
[10, 20, 30] reduce (item, accumulator = 0) -> accumulator + item
