%dw 2.0
import dw::core::Strings
output application/json
---
{ title: Strings::capitalize("premium gift wrap"), field: Strings::camelize("shipping_address") }
