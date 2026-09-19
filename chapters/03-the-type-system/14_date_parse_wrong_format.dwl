%dw 2.0
output application/json
---
{ placed: payload.placed as Date {format: "MM/dd/yyyy"} }
