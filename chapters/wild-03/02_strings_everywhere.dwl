%dw 2.0
output application/json
---
{
  types:      payload[0] mapObject { ($$): typeOf($) as String },
  uncoerced:  payload map { sku: $.sku, qty: $.qty },
  arithmetic: payload map ($.qty * $.price),
  joined:     payload map ($.qty ++ $.price),
  sorted:     (payload orderBy $.qty) map $.qty
}
