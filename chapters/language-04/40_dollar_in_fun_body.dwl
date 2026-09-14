%dw 2.0
output application/json
fun lineTotal(item) = $.price * $.qty
---
payload.items map lineTotal($)
