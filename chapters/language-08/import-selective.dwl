%dw 2.0
output application/json
import capitalize, camelize from dw::core::Strings
---
{
  label:     capitalize("usb-c hub"),
  field:     camelize("unit_price"),
  withSpace: camelize("unit price")
}
