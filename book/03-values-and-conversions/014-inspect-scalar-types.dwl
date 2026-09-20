%dw 2.0
output application/json
---
{ price: typeOf(payload.price), qty: typeOf(payload.qty), numericPrice: payload.price is Number, textPrice: payload.price is String }
