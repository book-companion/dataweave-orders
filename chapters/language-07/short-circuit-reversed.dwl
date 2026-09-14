%dw 2.0
output application/json
---
(sizeOf(payload.items) > 0) and (payload.items != null)
