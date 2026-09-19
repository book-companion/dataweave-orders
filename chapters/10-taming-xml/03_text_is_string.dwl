%dw 2.0
output application/json
---
{
  raw:        payload.order.total,
  doubled:    payload.order.total * 2,
  joined:     payload.order.total ++ payload.order.total,
  coerced:    payload.order.total as Number,
  compared:   payload.order.total > 5,
  lineTotals: payload.order.*item map ($.@qty * 2.5)
}
