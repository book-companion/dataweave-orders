%dw 2.0
output application/json
---
{ oneToTwo: payload.items[1 to 2].sku, oneToFive: payload.items[1 to 5].sku }
