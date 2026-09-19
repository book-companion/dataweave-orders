%dw 2.0
input payload application/json streaming=true
output application/json
---
payload groupBy $.customer mapObject (orders, name) -> { (name): sizeOf(orders) }
