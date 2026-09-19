%dw 2.0
output application/json
---
{
  asIs:      read(payload, "application/csv"),
  headerAt3: read(payload, "application/csv", { headerLineNumber: 2 }),
  bodyAt4:   read(payload, "application/csv", { headerLineNumber: 2, bodyStartLineNumber: 3 })
}
