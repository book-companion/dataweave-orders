%dw 2.0
output application/json
---
"returned" match {
  case "shipped"   -> "On its way"
  case "delivered" -> "Complete"
}
