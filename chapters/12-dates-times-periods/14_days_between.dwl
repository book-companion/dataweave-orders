%dw 2.0
output application/json
---
{
  days:   daysBetween(|2026-06-16|, |2026-06-18|),
  daysDT: daysBetween(|2026-06-16T23:00:00Z|, |2026-06-18T01:00:00Z|)
}
