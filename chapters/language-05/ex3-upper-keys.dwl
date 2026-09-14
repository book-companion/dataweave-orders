%dw 2.0
output application/json
---
payload.items[0] mapObject (value, key) -> { (upper(key)): value }
