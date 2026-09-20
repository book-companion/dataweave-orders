%dw 2.0
output application/json
fun discount(rate) = (price) -> price * (1 - rate)
var tenOff = discount(0.1)
---
{ single: tenOff(20), direct: discount(0.1)(20), typeName: typeOf(tenOff) }
