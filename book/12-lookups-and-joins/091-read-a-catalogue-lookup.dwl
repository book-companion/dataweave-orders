%dw 2.0
output application/json
var catalogue = { "PEN-01": { name: "Gel pen" }, "PAD-22": { name: "A5 notepad" } }
---
payload.items map (item) -> { sku: item.sku, name: catalogue[item.sku].name default "(not in catalogue)", qty: item.qty }
