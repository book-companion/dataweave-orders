%dw 2.0
output application/json
---
{
  defaultEscape:   read(payload, "application/csv") map $.name,
  backslashEscape: read(payload, "application/csv", { escape: "\\" }) map $.name
}
