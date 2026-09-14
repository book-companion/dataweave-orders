%dw 2.0
input payload application/json streaming=true
output application/json
---
payload map (order) -> {
  id: order.orderId,
  buyer: order.customer,
  total: order.total
}
