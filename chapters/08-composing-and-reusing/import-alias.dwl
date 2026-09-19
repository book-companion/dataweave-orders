%dw 2.0
output application/json
import dw::core::Strings as Str
---
{ one: Str::pluralize("order"), many: Str::singularize("boxes") }
