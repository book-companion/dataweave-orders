%dw 2.0
output application/json indent=false, skipNullOn="objects"
---
{
  orderId: payload.orderId,
  tags: payload.tags,
  items: payload.items map { sku: $.sku, note: $.note }
}
