%dw 2.0
output application/json
fun net(price) = price * 0.9
fun net(price) = price * 0.8
---
net(20)
