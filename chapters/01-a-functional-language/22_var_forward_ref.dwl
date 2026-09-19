%dw 2.0
output application/json
var total = sum(lineTotals)
var lineTotals = payload.items map ($.price * $.qty)
---
{ total: total }
