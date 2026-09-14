%dw 2.0
output application/json
fun classify(order) = { orderId: order.orderId, lines: sizeOf(order.items default []) }
---
payload map classify
