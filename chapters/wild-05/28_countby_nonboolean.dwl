%dw 2.0
import countBy from dw::core::Arrays
output application/json
---
{ n: payload.items countBy (i) -> i.qty }
