%dw 2.0
import leftJoin from dw::core::Arrays
output application/json
var catalog = [
  { sku: "PEN-01", name: "Gel pen" },
  { sku: "PAD-22", name: "A5 notepad" }
]
---
leftJoin(payload.items, catalog, (i) -> i.sku, (c) -> c.sku)
  map { sku: $.l.sku, qty: $.l.qty, name: $.r.name default "(not in catalog)" }
