%dw 2.0
output application/json
var encoded = '{"orderId":"A-1001","qty":4}'
var order = read(encoded, "application/json")
---
{ parsed: order, encodedAgain: write(order, "application/json", { indent: false }) }
