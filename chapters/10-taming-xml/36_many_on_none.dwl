%dw 2.0
output application/json
---
{
  many:      payload.order.*item,
  mapped:    payload.order.*item map $.@sku,
  guarded:   (payload.order.*item default []) map $.@sku,
  count:     sizeOf(payload.order.*item default [])
}
