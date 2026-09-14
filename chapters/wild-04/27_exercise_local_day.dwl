%dw 2.0
output application/json
var orders = [
  { id: "A-1001", placedAt: |2026-06-16T02:30:00Z| },
  { id: "A-1002", placedAt: |2026-06-16T14:30:00Z| },
  { id: "A-1003", placedAt: |2026-06-17T05:30:00Z| }
]
fun byDay(zone) = (orders groupBy (($.placedAt >> zone) as String {format: "yyyy-MM-dd"})) mapObject { ($$): $.id }
---
{
  utc: byDay("UTC"),
  la:  byDay("America/Los_Angeles")
}
