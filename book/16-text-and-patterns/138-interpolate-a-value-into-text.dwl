%dw 2.0
output application/json
var id = "A-1001"
---
{ label: "Order $(id)", literalPrice: "\$6.00" }
