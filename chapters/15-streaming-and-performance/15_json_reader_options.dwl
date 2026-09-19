%dw 2.0
input payload application/json bogus=true
output application/json
---
payload[0].orderId
