%dw 2.0
output application/json
---
payload.tags map (tag) -> tag match {
  case is Null -> "(none)"
  case "rush"  -> "RUSH"
  case t is String -> t
}
