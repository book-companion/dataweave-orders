%dw 2.0
output application/json
var raw = '{ "sku": "PEN-01", "sku": "PAD-22", "qty": 4 }'
---
{
  asIs:       read(raw, "application/json"),
  collapsed:  read(raw, "application/json", { duplicateKeyAsArray: true })
}
