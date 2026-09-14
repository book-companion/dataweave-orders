%dw 2.0
output application/json
var discountedBy = (price, rate = 0.1) -> price * (1 - rate)
---
{ withDefault: discountedBy(20), explicit: discountedBy(20, 0.3) }
