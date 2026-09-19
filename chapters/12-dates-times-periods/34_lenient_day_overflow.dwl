%dw 2.0
output application/json
---
{
  feb31: "31/02/2026" as Date {format: "dd/MM/yyyy"},
  apr31: "31/04/2026" as Date {format: "dd/MM/yyyy"},
  feb29: "29/02/2026" as Date {format: "dd/MM/yyyy"}
}
