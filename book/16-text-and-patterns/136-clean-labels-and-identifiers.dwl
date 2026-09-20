%dw 2.0
import capitalize, camelize, substringAfter, pluralize, leftPad from dw::core::Strings
output application/json
---
{
  title:  capitalize("premium gift wrap"),
  field:  camelize("shipping_address"),
  code:   substringAfter("SKU:AC-1099", ":"),
  label:  pluralize("box"),
  padded: "42" leftPad 6
}
