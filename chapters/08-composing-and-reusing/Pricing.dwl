%dw 2.0
fun withTax(amount) = amount * 1.20
fun discount(amount, pct) = amount * (1 - pct)
