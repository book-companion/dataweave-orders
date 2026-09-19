%dw 2.0
output application/json
---
{ fromInput: payload[1].price, literal: 6.0, computed: 2.5 * 4, passthrough: payload[2] }
