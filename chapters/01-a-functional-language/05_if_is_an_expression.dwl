%dw 2.0
output application/json
---
{
  id: payload.orderId,
  size: if (sizeOf(payload.items) > 2) "large" else "small",
  firstSku: payload.items[0].sku,
  lineTotals: payload.items map ($.price * $.qty),
  grandTotal: sum(payload.items map ($.price * $.qty))
}
