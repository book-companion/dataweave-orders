%dw 2.0
output application/json
import * from Orders
---
payload map (order) -> {
  orderId:  order.orderId,
  rate:     params.rate,
  rateType: typeOf(params.rate),
  total:    subtotal(order) * (1 + (params.rate as Number))
}
