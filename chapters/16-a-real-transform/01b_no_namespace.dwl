%dw 2.0
output application/json
---
{ orders: payload.orderBatch.*order, firstId: payload.orderBatch.order.@id }
