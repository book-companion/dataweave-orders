%dw 2.0
output application/json
fun net(p) = p * 0.9
fun withTax(p) = p * 1.2
fun compose(f, g) = (x) -> f(g(x))
var netThenTax = compose(withTax, net)
---
{
  nested: withTax(net(20)),
  composed: netThenTax(20),
  lines: payload.items map netThenTax($.price * $.qty)
}
