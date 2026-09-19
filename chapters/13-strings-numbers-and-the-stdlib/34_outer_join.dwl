%dw 2.0
import outerJoin from dw::core::Arrays
output application/json
var catalog = [
  { sku: "PEN-01", name: "Gel pen" },
  { sku: "STP-03", name: "Stapler" }
]
---
outerJoin(payload.items, catalog, (i) -> i.sku, (c) -> c.sku)
  map { sku: ($.l.sku default $.r.sku), name: $.r.name default "(not in catalog)", qty: $.l.qty default 0 }
