%dw 2.0
import between from dw::core::Periods
output application/json
var placedAt  = |2026-06-16T09:00:00Z|
var shippedAt = |2026-06-18T15:30:00Z|
---
{
  laterFirst:   between(shippedAt, placedAt),
  earlierFirst: between(placedAt, shippedAt),
  dates:        between(|2026-06-18|, |2026-06-16|),
  minus:        shippedAt - placedAt,
  minusType:    typeOf(shippedAt - placedAt) as String
}
