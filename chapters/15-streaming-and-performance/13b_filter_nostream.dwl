%dw 2.0
output application/json
---
payload filter ($.customer == "Dana" and $.total > 40) map { id: $.orderId, total: $.total }
