%dw 2.0
output application/json
---
{ b: 2, a: 1, c: 3 } orderBy (value, key) -> value
