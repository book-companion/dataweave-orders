%dw 2.0
output application/json
fun discount(rate) = (price) -> price * (1 - rate)
var clearance = discount(0.3)
---
payload.items map clearance($.price)
