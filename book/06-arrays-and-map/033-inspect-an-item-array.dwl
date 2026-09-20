%dw 2.0
output application/json
---
{ first: payload[0], secondSku: payload[1].sku, lastSku: payload[-1].sku, beyondEnd: payload[3] }
