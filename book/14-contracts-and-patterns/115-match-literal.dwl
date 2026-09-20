%dw 2.0
output application/json
---
payload.status match {
  case "shipped"   -> "On its way"
  case "delivered" -> "Complete"
  case "cancelled" -> "Refunded"
  else             -> "Processing"
}
