%dw 2.0
output application/json
var lineTotals = payload.items map ($.price * $.qty)
var total = sum(lineTotals)
---
{ lineTotals: lineTotals, total: total }
