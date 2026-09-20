%dw 2.0
output application/json
fun net(p) = p * 0.9
fun tax(rate) = (p) -> p * (1 + rate)
fun compose(f, g) = (x) -> f(g(x))
var netThenTax = compose(tax(0.2), net)
var taxThenNet = compose(net, tax(0.2))
---
{ netThenTax: netThenTax(20), taxThenNet: taxThenNet(20) }
