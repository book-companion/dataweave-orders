%dw 2.0
output application/json
fun discountedBy(amount, rate = 0.1) = amount * (1 - rate)
---
{ usual: discountedBy(20), special: discountedBy(20, 0.3) }
