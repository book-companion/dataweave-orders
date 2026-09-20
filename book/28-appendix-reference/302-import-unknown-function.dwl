%dw 2.0
output application/json
import capitalise from dw::core::Strings
---
capitalise("gel pen")
