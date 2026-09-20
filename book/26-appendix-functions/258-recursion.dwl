%dw 2.0
output application/json
fun countdown(n) = if (n == 0) [0] else [n] ++ countdown(n - 1)
fun total(items) = if (isEmpty(items)) 0 else items[0].price * items[0].qty + total(items[1 to -1] default [])
---
{ countdown: countdown(3), orderTotal: total(payload.items) }
