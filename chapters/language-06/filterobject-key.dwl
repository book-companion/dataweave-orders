%dw 2.0
output application/json
---
{
  byName: payload[0] filterObject (value, key) -> key != "orderId",
  byPrefix: payload[0] filterObject (value, key) -> !((key as String) startsWith "order")
}
