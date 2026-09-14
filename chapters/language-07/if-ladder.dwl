%dw 2.0
output application/json
fun tier(total) =
  if (total >= 500) "platinum"
  else if (total >= 100) "gold"
  else "standard"
---
{
  thisOrder: tier(payload.total),
  others: [99.99, 100, 499, 500] map tier($)
}
