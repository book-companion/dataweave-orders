%dw 2.0
output application/json
fun tier(total) = total match {
  case t if (t >= 500) -> "platinum"
  case t if (t >= 100) -> "gold"
  case t if (t > 0)    -> "standard"
  else                 -> "empty cart"
}
fun tierWrongOrder(total) = total match {
  case t if (t > 0)    -> "standard"
  case t if (t >= 100) -> "gold"
  case t if (t >= 500) -> "platinum"
  else                 -> "empty cart"
}
---
{
  right: [0, 32, 150, 600] map tier($),
  wrong: [0, 32, 150, 600] map tierWrongOrder($)
}
