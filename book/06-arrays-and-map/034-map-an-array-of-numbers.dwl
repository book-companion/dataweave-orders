%dw 2.0
output application/json
---
[2.5, 6, 1] map (price) -> price * 2
