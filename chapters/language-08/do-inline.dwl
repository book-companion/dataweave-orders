%dw 2.0
output application/json
import * from Orders
---
payload map (order) -> do {
  var sub = subtotal(order)
  ---
  { orderId: order.orderId, subtotal: sub, tax: withTax(sub) - sub }
}
