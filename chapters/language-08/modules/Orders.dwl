%dw 2.0
fun subtotal(order) = sum(order.items map (i) -> i.price * i.qty)
fun withTax(amount) = amount * 1.08
