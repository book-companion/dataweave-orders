%dw 2.0
input payload application/json streaming=true
output application/json
---
(payload orderBy -$.total)[0 to 2] map { id: $.orderId, total: $.total }
