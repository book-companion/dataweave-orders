%dw 2.0
output application/json
fun asPrice(p) = p match {
  case is Number -> p
  case is String -> p as Number
  case is Null   -> 0
  else -> "unexpected " ++ typeOf(p)
}
---
["6.0", 6, null, true] map asPrice($)
