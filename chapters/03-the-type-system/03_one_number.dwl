%dw 2.0
output application/json
---
{
  intType: typeOf(79),
  decType: typeOf(79.0),
  equal: 79 == 79.0,
  division: 100 / 3,
  tenOverFour: 10 / 4,
  lineTotal: 2.5 * 4,
  pointOnePlusPointTwo: 0.1 + 0.2,
  big: 12345678901234567890 + 1,
  bigTimes: 2.5 * 12345678901234567890
}
