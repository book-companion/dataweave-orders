%dw 2.0
output application/json
import * from dw::core::Strings
---
{
  mouse: capitalize("wireless mouse"),
  pen:   capitalize("gel pen"),
  snake: capitalize("unit_price")
}
