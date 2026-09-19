%dw 2.0
output application/json

var taxRate = 0.08
fun lineTotal(item) = item.price * item.qty
fun subtotal(order) = sum(order.items map lineTotal($))
fun withTax(amount) = amount * (1 + taxRate)
---
payload map (order) -> {
  orderId:  order.orderId,
  subtotal: subtotal(order),
  total:    withTax(subtotal(order))
}
