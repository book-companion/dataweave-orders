%dw 2.0
output application/json
---
{ total: sum(payload.items map ($.price * $.qty)) }
