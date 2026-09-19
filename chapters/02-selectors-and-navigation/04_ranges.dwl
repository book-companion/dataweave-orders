%dw 2.0
output application/json
---
{
  firstTwo: payload.items[0 to 1].sku,
  lastTwo: payload.items[-2 to -1].sku,
  reversed: payload.items[-1 to 0].sku,
  pastTheEnd: payload.items[1 to 10].sku,
  outOfRange: payload.items[5],
  stringSlice: payload.orderId[0 to 1]
}
