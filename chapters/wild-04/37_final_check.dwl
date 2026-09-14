%dw 2.0
output application/json
var placedAt = |2026-06-16T14:30:00-04:00|
var orders = [{ id: "A-1001", placedAt: |2026-06-16T02:30:00Z| }, { id: "A-1002", placedAt: |2026-06-16T14:30:00Z| }]
---
{
  roundTripEqual: ((placedAt as LocalDateTime) as DateTime) == placedAt,
  roundTrip:      (placedAt as LocalDateTime) as DateTime,
  dayCheckBad:    ("31/02/2026" as Date {format: "dd/MM/yyyy"}) as String {format: "dd/MM/yyyy"} == "31/02/2026",
  dayCheckGood:   ("16/06/2026" as Date {format: "dd/MM/yyyy"}) as String {format: "dd/MM/yyyy"} == "16/06/2026",
  "type":         typeOf(placedAt) as String,
  groupByDate:    orders groupBy ($.placedAt as Date)
}
