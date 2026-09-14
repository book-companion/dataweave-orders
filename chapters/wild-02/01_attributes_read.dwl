%dw 2.0
output application/json
---
{
  orderId:  payload.order.@id,
  channel:  payload.order.@channel,
  amount:   payload.order.total,
  currency: payload.order.total.@currency,
  amountType: typeOf(payload.order.total) as String
}
