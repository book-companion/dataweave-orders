%dw 2.0
output application/json
---
{
  first: { discount: 5, discount: 10, discount: 15 }.discount,
  all: { discount: 5, discount: 10, discount: 15 }.*discount,
  absent: { discount: 5 }.*rebate
}
