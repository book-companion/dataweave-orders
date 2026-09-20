%dw 2.0
import leftJoin from dw::core::Arrays
output application/json
var items = [{ sku: "PEN-01", qty: 4 }]
var catalogue = [{ sku: "PEN-01", name: "Old label" }, { sku: "PEN-01", name: "New label" }]
---
leftJoin(items, catalogue, (item) -> item.sku, (product) -> product.sku)
