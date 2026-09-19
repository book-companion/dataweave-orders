%dw 2.0
output application/json
---
(payload orderBy -$.total)[0 to 2] map { id: $.orderId, total: $.total }
