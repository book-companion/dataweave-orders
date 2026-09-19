%dw 2.0
output application/json
---
{
  placed: payload.placed as Date {format: "dd/MM/yyyy"},
  placedType: typeOf(payload.placed as Date {format: "dd/MM/yyyy"}),
  iso: "2026-09-13" as Date,
  nextWeek: (payload.placed as Date {format: "dd/MM/yyyy"}) + |P7D|
}
