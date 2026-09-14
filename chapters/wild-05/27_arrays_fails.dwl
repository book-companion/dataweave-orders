%dw 2.0
import sumBy, countBy from dw::core::Arrays
output application/json
---
{ discounts: payload.items sumBy (i) -> i.discount }
