%dw 2.0
output application/json
fun lineTotal(item) = item.price * item.qty
---
{
  applied:   payload[0].items map lineTotal($),
  asLambda:  payload[0].items map (item) -> lineTotal(item),
  bareName:  payload[0].items map lineTotal
}
