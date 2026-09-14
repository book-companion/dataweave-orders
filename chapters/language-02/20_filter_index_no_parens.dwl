%dw 2.0
output application/json
---
payload.items filter ($.qty > 2)[0]
