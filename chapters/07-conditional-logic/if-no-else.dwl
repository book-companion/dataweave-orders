%dw 2.0
output application/json
---
if (payload.total > 100) "free"
