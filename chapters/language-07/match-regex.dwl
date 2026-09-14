%dw 2.0
output application/json
---
(payload.items.sku ++ ["pen-1", "X-9999"]) map (sku) -> sku match {
  case matches /^([A-Z]{3})-(\d{2})$/ -> { sku: sku, family: $[1], number: $[2] as Number }
  else -> { sku: sku, error: "unrecognized format" }
}
