%dw 2.0
output application/json
var prices = [19.99, 5.00, 12.50]
---
{
  subtotal: sum(prices),
  average:  avg(prices),
  rounded:  round(avg(prices)),
  withVat:  round(sum(prices) * 1.2),
  lineTotals: payload.items map ($.price * $.qty),
  orderTotal: sum(payload.items map ($.price * $.qty)),
  biggest: max(payload.items.qty),
  emptySum: sum([]),
  emptyMax: max([]),
  halves: [2.5, 3.5] map round($)
}
