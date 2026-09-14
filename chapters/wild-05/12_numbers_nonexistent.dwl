%dw 2.0
import toOctal from dw::core::Numbers
output application/json
---
toOctal(8)
