%dw 2.0
output application/json
---
{ dollarOne: "AC-1099" replace /(\d+)/ with "[$1]" }
