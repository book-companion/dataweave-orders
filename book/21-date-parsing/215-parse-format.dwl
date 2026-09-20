%dw 2.0
output application/json
---
{
  parsed:   "16/06/2026" as Date {format: "dd/MM/yyyy"},
  display:  |2026-06-16| as String {format: "dd MMM yyyy"},
  iso:      |2026-06-16| as String,
  isoIn:    "2026-06-16T14:30:00Z" as DateTime,
  withTime: "2026-06-16 14:30" as LocalDateTime {format: "yyyy-MM-dd HH:mm"},
  parsedType: typeOf("16/06/2026" as Date {format: "dd/MM/yyyy"}) as String
}
