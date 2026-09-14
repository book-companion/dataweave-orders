%dw 2.0
output application/json
---
{
  all:  payload.order.@,
  keys: keysOf(payload.order.@) map ($ as String),
  qtys: payload.order.*item.@qty
}
