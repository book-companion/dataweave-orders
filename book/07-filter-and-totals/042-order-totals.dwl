%dw 2.0
output application/json
var items = payload.items default []
var lineTotals = items map (item) -> item.price * item.qty
var subtotal = sum(lineTotals)
var delivery = if (subtotal == 0 or subtotal >= 100) 0 else 4.99
---
{
  orderId: payload.orderId,
  lineCount: sizeOf(items),
  lineTotals: lineTotals,
  subtotal: subtotal,
  delivery: delivery,
  grandTotal: subtotal + delivery
}
