%dw 2.0
output application/json
---
{ product: payload.price * payload.qty, joined: payload.price ++ payload.qty, sameValue: payload.price == 2.5, convertedValue: (payload.price as Number) == 2.5 }
