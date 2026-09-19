%dw 2.0
import parseDate, money from orders::Feed
output application/json
---
{
  iso:   parseDate("2026-06-14"),
  us:    parseDate("06/16/2026"),
  stamp: parseDate("2026-06-18T09:30:00Z"),
  price: money("6.00") * 2,
  typeOfDate: typeOf(parseDate("06/16/2026"))
}
