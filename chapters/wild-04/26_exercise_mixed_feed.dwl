%dw 2.0
output application/json
fun normalise(v) = v match {
  case n is Number -> n as DateTime
  case s is String -> if (s matches /\d{4}-\d{2}-\d{2}T.*/) s as DateTime
    else if (s matches /\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}/) s as LocalDateTime {format: "dd/MM/yyyy HH:mm"}
    else s as Date {format: "MM/dd/yyyy"}
}
---
payload map { id: $.id, placedAt: normalise($.placed), kind: typeOf(normalise($.placed)) as String }
