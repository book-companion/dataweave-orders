%dw 2.0
output application/json
---
{
  oneLevel: flatten([[1, 2], [3, 4], [5]]),
  onlyOne:  flatten([[1, [2]], [3]]),
  notNested: flatten([1, 2, 3])
}
