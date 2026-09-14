%dw 2.0
output application/json
---
{ notes: payload.items.note, shippingAttrs: payload.shipping.@, slice: payload.items[0 to 5] }
