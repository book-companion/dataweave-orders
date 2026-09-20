%dw 2.0
output application/json
---
{
  first: payload.sku,
  all: payload.*sku,
  keys: keysOf(payload)
}
