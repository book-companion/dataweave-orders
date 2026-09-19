%dw 2.0
output application/json
---
payload.items filter (item, index) -> index > 0
