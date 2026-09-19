%dw 2.0

var taxRate = 0.08
fun lineTotal(item) = item.price * item.qty
fun subtotal(order) = sum(order.items map lineTotal($))
fun withTax(amount) = amount * (1 + taxRate)
