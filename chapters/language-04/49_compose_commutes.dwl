%dw 2.0
output application/json
fun net(p) = p * 0.9
fun withTax(p) = p * 1.2
fun compose(f, g) = (x) -> f(g(x))
---
{ netThenTax: compose(withTax, net)(20), taxThenNet: compose(net, withTax)(20) }
