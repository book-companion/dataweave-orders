%dw 2.0
output application/json
fun discount(rate) = (price) -> price * (1 - rate)
---
discount(0.3)
