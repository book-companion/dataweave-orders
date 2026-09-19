%dw 2.0
output application/json
---
payload[0] filterObject (value, key) -> !(key startsWith "order")
