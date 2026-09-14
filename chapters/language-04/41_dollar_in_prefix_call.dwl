%dw 2.0
output application/json
---
map(payload.items, $.price * $.qty)
