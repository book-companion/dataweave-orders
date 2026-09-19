%dw 2.0
import leftPad from dw::core::Strings
output application/json
---
{ c: 6 leftPad "42" }
