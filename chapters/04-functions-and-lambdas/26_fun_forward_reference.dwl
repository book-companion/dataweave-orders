%dw 2.0
output application/json
fun grossLine(item) = net(item.price) * item.qty
fun net(price) = price * 0.9
---
payload.items map grossLine($)
