%dw 2.0
output application/xml
---
{ item: { wrapped: payload.item.escaped as cdata } }
