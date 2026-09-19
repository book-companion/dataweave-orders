%dw 2.0
output application/json
var field = "tier"
---
{
  plain: payload["orderId"],
  chained: payload["customer"]["email"],
  computed: payload.customer[field],
  hyphenated: { "ship-to": "Lisbon" }["ship-to"]
}
