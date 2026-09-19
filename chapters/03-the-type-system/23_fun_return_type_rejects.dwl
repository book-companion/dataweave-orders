%dw 2.0
output application/json
fun label(price: Number): String = price * 2
---
{ label: label(2.5) }
