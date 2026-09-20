%dw 2.0
output application/json
---
{ named: payload.items map (item) -> item.price * item.qty, short: payload.items map ($.price * $.qty) }
