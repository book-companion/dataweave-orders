%dw 2.0
output application/json
---
{ r1: random(), r2: random(), u1: uuid(), u2: uuid(), sameR: random() == random() }
