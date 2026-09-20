%dw 2.0
output application/json
---
{ fraction: 10 / 4, decimalSum: 0.1 + 0.2, sameNumber: 79 == 79.0 }
