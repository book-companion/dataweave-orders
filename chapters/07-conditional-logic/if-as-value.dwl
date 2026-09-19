%dw 2.0
output application/json
var total = payload.total
---
{
  shipping: if (total >= 100) 0 else 9.99,
  grand: total + (if (total >= 100) 0 else 9.99),
  label: "Order " ++ payload.orderId ++ (if (payload.coupon != null) " (coupon)" else "")
}
