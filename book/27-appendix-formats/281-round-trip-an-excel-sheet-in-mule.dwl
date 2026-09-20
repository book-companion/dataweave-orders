%dw 2.0
output application/json
var bytes = write({Orders: [{id: "A-1001", total: 32}]}, "application/xlsx")
---
read(bytes, "application/xlsx")
