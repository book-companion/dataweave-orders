%dw 2.0
output application/json
---
{
  defaultRead: read(payload, "application/csv"),
  keepEmpty:   read(payload, "application/csv", { ignoreEmptyLine: false })
}
