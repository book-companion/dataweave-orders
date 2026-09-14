%dw 2.0
import join, leftJoin from dw::core::Arrays
output application/json
var catalog = [
  { sku: "PEN-01", name: "Gel pen" },
  { sku: "PAD-22", name: "A5 notepad" }
]
---
{
  inner: join(payload.items, catalog, (i) -> i.sku, (c) -> c.sku)
           map { sku: $.l.sku, name: $.r.name, qty: $.l.qty },
  left:  leftJoin(payload.items, catalog, (i) -> i.sku, (c) -> c.sku)
           map { sku: $.l.sku, name: $.r.name default "(not in catalog)" }
}
