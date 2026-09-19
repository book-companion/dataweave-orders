%dw 2.0
output application/json
---
payload.items map {
  sku: $.sku,
  price: $.price,
  priceText: $.price as String {format: "0.00"},
  lineTotal: ($.price * $.qty) as String {format: "#,##0.00"}
}
