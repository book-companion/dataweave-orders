%dw 2.0
output application/json
---
{
  firstOnly: payload.order.items.item,
  countOfKeys: sizeOf(payload.order.items),
  all: payload.order.items.*item
}
