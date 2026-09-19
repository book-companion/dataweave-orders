%dw 2.0
output application/json
var taxRate = 0.08
fun withTax(amount) = do {
  var taxRate = 0.20
  ---
  amount * (1 + taxRate)
}
---
{ inDo: withTax(100), inHeader: 100 * (1 + taxRate) }
