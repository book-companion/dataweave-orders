%dw 2.0
output application/json
var sku = "AC-1099-XL"
---
{
  validEmail: "buyer@example.com" matches /^[^@\s]+@[^@\s]+\.[^@\s]+$/,
  normalized: "AC 1099 XL" replace /\s+/ with "-",
  parts:      sku scan /([A-Z]+)-(\d+)-(\w+)/
}
