%dw 2.0
import * from dw::core::Arrays
import * from dw::core::Objects
output application/json
---
{ x: [1,2,3] divideBy 2 }
