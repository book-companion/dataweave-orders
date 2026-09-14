%dw 2.0
output application/json
---
{
  bySku: (payload distinctBy (line) -> line.sku) map $.sku,
  byLine: (payload distinctBy (line) -> { sku: line.sku, orderId: line.orderId }) map ($.orderId ++ "/" ++ $.sku)
}
