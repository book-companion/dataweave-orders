%dw 2.0
output application/json
---
{
  h1: read(payload, "application/csv", { headerLineNumber: 1 })[0],
  h2: read(payload, "application/csv", { headerLineNumber: 2 })[0],
  h3: read(payload, "application/csv", { headerLineNumber: 3 })[0],
  h2b4: read(payload, "application/csv", { headerLineNumber: 2, bodyStartLineNumber: 4 })[0],
  b3only: read(payload, "application/csv", { bodyStartLineNumber: 3 })[0]
}
