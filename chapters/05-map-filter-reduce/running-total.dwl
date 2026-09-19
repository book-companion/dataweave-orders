%dw 2.0
output application/json
---
payload.items reduce (item, acc = []) -> acc ++ [ (acc[-1] default 0) + item.price * item.qty ]
