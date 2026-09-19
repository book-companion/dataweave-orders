%dw 2.0
input payload application/json streaming=true
output application/json
---
payload filter ($.customer == "Dana" and $.total > 40) map { id: $.orderId, total: $.total }
