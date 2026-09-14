%dw 2.0
output application/json
---
{
  bulkFirst: (payload.items filter ($.qty > 2))[0].sku,
  bulkLast: (payload.items filter ($.qty > 2))[-1].sku,
  filterSelector: payload.items[?($.qty > 2)].sku
}
