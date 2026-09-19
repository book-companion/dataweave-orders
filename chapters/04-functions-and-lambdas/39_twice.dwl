%dw 2.0
output application/json
fun net(p) = p * 0.9
fun twice(f) = (x) -> f(f(x))
---
{ once: net(20), twice: twice(net)(20), lines: payload.items map twice(net)($.price) }
