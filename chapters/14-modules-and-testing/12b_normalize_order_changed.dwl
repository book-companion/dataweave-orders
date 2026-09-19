%dw 2.0
import orderTotal, lineTotal from orders::OrderMath
output application/json
---
{
  id: payload.orderId,
  customer: payload.customer,
  lines: payload.items map (i) -> { sku: i.sku, qty: i.qty, lineTotal: lineTotal(i) },
  total: orderTotal(payload.items) * 1.2
}
