%dw 2.0
output application/xml writeDeclaration=false, indent=false
---
{ order @(id: payload.order.@id): { customer: payload.order.customer } }
