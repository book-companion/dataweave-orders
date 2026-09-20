%dw 2.0
output application/json
fun receipt(price, qty) = do {
  var amount = price * qty
  var delivery = if (amount >= 100) 0 else 4.99
  ---
  { amount: amount, delivery: delivery, total: amount + delivery }
}
---
{ below: receipt(99.99, 1), at: receipt(100, 1) }
