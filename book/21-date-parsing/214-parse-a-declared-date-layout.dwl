%dw 2.0
output application/json
var placed = "16/06/2026" as Date {format: "dd/MM/yyyy"}
---
{ kind: typeOf(placed), suppliedLayout: placed, iso: placed as String {format: "yyyy-MM-dd"} }
