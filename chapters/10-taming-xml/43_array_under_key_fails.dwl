%dw 2.0
output application/xml
---
{ items: payload.order.*item }
