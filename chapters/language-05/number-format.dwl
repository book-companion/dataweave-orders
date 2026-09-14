%dw 2.0
output application/json
---
{ fromInput: payload.items[1].price, literal: 6.0, computed: 2.5 * 4, passthrough: payload.items[2] }
