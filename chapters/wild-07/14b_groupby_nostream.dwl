%dw 2.0
output application/json
---
payload groupBy $.customer mapObject (orders, name) -> { (name): sizeOf(orders) }
