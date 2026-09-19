%dw 2.0
import * from dw::core::Strings
output application/json
---
{
  underscore:  capitalize("unit_price"),
  hyphen:      capitalize("usb-c hub"),
  camelSpace:  camelize("unit price"),
  camelUnder:  camelize("unit_price"),
  camelDash:   camelize("unit-price"),
  dasherized:  dasherize("Unit Price"),
  underscored: underscore("unitPrice"),
  singular:    singularize("boxes"),
  pluralIrreg: pluralize("child"),
  pluralS:     pluralize("status"),
  afterMissing: substringAfter("AC-1099", ":"),
  afterLast:   substringAfterLast("A-1001-PEN-01", "-"),
  before:      substringBefore("SKU:AC-1099", ":"),
  padLonger:   "1234567" leftPad 6,
  rightPad:    "42" rightPad 6,
  padChar:     leftPad("42", 6, "0"),
  clipped:     "premium gift wrap" withMaxSize 7,
  blank:       isBlank("   "),
  rep:         repeat("-", 5)
}
