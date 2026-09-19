%dw 2.0
output application/json
fun discountedBy(price, rate) = price * (1 - rate)
---
discountedBy(20)
