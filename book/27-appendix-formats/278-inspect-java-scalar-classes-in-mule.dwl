%dw 2.0
output application/json
---
{
  integerClass: payload.integer.^class,
  decimalClass: payload.decimal.^class
}
