%dw 2.0
output application/json
---
{ onNull: null.anything, chained: payload.warehouse.bay.shelf, onNumber: (42).anything, onArrayOfNumbers: [1, 2].anything }
