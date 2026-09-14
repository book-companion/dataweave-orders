%dw 2.0
output application/json
---
payload.items map (item) -> item.price * item.qty
