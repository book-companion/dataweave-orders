%dw 2.0
output application/json
fun withTax(amount) = amount * (1 + taxRate)
var total = withTax(100)
var taxRate = 0.08
---
total
