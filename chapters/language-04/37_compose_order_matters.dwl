%dw 2.0
output application/json
fun lessFive(p) = p - 5
fun tax(rate) = (p) -> p * (1 + rate)
fun compose(f, g) = (x) -> f(g(x))
var discountThenTax = compose(tax(0.2), lessFive)
var taxThenDiscount = compose(lessFive, tax(0.2))
---
{ discountThenTax: discountThenTax(20), taxThenDiscount: taxThenDiscount(20) }
