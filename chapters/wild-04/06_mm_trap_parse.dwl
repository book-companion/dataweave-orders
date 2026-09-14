%dw 2.0
output application/json
---
{ wrong: "16/06/2026 14:30" as LocalDateTime {format: "dd/mm/yyyy HH:mm"} }
