%dw 2.0
output application/json indent=false
---
payload map { orderId: $.orderId, lines: sizeOf($.items) }
