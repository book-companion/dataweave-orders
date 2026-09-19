%dw 2.0
output application/csv separator=";", quoteValues=true, header=true
---
payload map {
  SKU: $.sku,
  Quantity: $.qty
}
