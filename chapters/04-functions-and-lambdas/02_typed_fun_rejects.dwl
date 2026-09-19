%dw 2.0
output application/json
fun net(price: Number): Number = price * 0.9
---
net(payload.customer)
