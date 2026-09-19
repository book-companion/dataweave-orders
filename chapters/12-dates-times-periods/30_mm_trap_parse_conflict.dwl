%dw 2.0
output application/json
---
{ wrong: "2026-06-16" as Date {format: "yyyy-mm-dd"} }
