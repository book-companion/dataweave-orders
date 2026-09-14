%dw 2.0
output application/json
---
{
  hasItems: (payload.items != null) and (sizeOf(payload.items) > 0),
  noItems:  (payload.items == null) or (sizeOf(payload.items) == 0)
}
