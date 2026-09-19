%dw 2.0
output application/json
var placed = payload.placed as Date {format: "dd/MM/yyyy"}
---
{
  asIs: placed,
  toStringNoFormat: placed as String,
  toStringIso: placed as String {format: "yyyy-MM-dd"},
  afterArithmetic: placed + |P1D|
}
