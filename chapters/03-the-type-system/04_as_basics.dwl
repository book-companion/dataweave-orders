%dw 2.0
output application/json
---
{
  fromString: "42" as Number,
  decimalString: "2.50" as Number,
  toString: 42 as String,
  decimalToString: 6.0 as String,
  productToString: (2.5 * 4) as String,
  flag: "true" as Boolean,
  upperFlag: "TRUE" as Boolean,
  alreadyNumber: 42 as Number
}
