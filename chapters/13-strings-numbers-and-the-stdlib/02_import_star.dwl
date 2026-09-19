%dw 2.0
import * from dw::core::Strings
output application/json
---
{ title: capitalize("premium gift wrap"), field: camelize("shipping_address") }
