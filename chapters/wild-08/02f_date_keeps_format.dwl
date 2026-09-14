%dw 2.0
import parseDate from orders::Feed
output application/json
---
{
  us:       parseDate("06/16/2026"),
  usPlus:   parseDate("06/16/2026") + |P1D|,
  usIso:    parseDate("06/16/2026") as String { format: "yyyy-MM-dd" },
  usType:   typeOf(parseDate("06/16/2026")),
  sameDay:  parseDate("06/16/2026") == parseDate("2026-06-16")
}
