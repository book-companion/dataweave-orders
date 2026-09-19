%dw 2.0
output application/json
---
{
  whole: typeOf(payload),
  id: typeOf(payload.orderId),
  items: typeOf(payload.items),
  price: typeOf(payload.items[0].price),
  qty: typeOf(payload.items[0].qty),
  missing: typeOf(payload.coupon),
  aKey: typeOf(keysOf(payload)[0]),
  date: typeOf(|2026-09-13|),
  dateTime: typeOf(|2026-09-13T09:15:00Z|),
  localDateTime: typeOf(|2026-09-13T09:15:00|),
  time: typeOf(|09:15:00Z|),
  localTime: typeOf(|09:15:00|),
  period: typeOf(|P2D|),
  zone: typeOf(|+02:00|)
}
