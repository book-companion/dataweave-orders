%dw 2.0
output application/json
fun net(price) = price * 0.9
---
net(20)
