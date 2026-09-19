%dw 2.0
output application/json
var text = '[{"orderId":"A-1001","total":8.5},{"orderId":"A-1002","total":13}]'
---
read(text, "application/json", { streaming: true }) map $.orderId
