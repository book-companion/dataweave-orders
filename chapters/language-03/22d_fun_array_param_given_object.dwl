%dw 2.0
output application/json
fun count(xs: Array): Number = sizeOf(xs)
---
{ n: count(payload.items[0]) }
