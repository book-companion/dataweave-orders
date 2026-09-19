%dw 2.0
input payload application/json streaming=true
output application/json
fun summarise(@StreamCapable() orders) =
  orders map (o) -> { id: o.orderId, total: o.total }
---
summarise(payload)
