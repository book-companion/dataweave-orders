%dw 2.0
ns ord http://shipping.acme.com/orders
input payload application/xml streaming=true
output application/json
---
payload.ord#orderBatch.*ord#order map $.@id
