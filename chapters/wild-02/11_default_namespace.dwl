%dw 2.0
ns o http://acme.com/orders
output application/json
---
{
  unprefixed: payload.order.total,
  withNs:     payload.o#order.o#total,
  attr:       payload.o#order.@id
}
