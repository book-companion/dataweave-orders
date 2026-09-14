%dw 2.0
output application/json
var field = "grandTotal"
---
{
  (field): 43.5,
  ("total_" ++ payload[0].sku): payload[0].price * payload[0].qty,
  (payload[0].qty): "a number as a key"
}
