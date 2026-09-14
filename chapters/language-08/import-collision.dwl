%dw 2.0
output application/json
import * from dw::core::Strings
fun capitalize(s) = upper(s)
---
capitalize("gel pen")
