%dw 2.0
output application/json
---
{
  defaultQuote: read(payload, "application/csv") map $.name,
  singleQuote:  read(payload, "application/csv", { quote: "'" }) map $.name
}
