%dw 2.0
output application/json
---
{ id: payload.orderId, total: payload.items sumBy (i) -> i.price * i.qty
