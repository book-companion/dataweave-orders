%dw 2.0
output application/json
---
{ indexOnObject: payload.customer[0], indexOnString: payload.customer.name[0], indexOnNull: payload.warehouse[0] }
