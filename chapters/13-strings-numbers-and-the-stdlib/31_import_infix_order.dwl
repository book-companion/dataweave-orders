%dw 2.0
import * from dw::core::Strings
output application/json
---
{ a: "42" leftPad 6, b: leftPad("42", 6), c: 6 leftPad "42" }
