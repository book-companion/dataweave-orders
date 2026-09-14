%dw 2.0
output application/json
var discountedBy = (price, rate) -> price * (1 - rate)
---
20 discountedBy 0.1
