%dw 2.0
output application/json
---
payload.items reduce (item, acc) -> if (item.price * item.qty > acc.price * acc.qty) item else acc
