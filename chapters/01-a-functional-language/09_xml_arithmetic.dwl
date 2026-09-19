%dw 2.0
output application/json
---
payload.order.items.*item map ($.price * $.qty)
