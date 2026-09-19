%dw 2.0
output application/json
var countdown = (n) -> if (n == 0) [0] else [n] ++ countdown(n - 1)
---
countdown(3)
