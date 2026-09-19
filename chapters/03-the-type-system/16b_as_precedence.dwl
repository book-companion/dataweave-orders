%dw 2.0
output application/json
---
{
  unparenthesised: 2.5 * 4 as String {format: "0.00"},
  parenthesised: (2.5 * 4) as String {format: "0.00"},
  whatItDid: typeOf(2.5 * 4 as String {format: "0.00"})
}
