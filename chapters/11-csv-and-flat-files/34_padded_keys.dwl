%dw 2.0
output application/json
---
{
  keys:     keysOf(read(payload, "application/csv", { separator: ";" })[0]) map ($ as String),
  bareKey:  read(payload, "application/csv", { separator: ";" })[0].unit_price,
  spaceKey: read(payload, "application/csv", { separator: ";" })[0]."name         "
}
