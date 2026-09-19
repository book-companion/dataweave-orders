%dw 2.0
output application/json
---
{
  fromCdata:   payload.item.description,
  fromEscaped: payload.item.escaped,
  same:        trim(payload.item.description) == payload.item.escaped
}
