%dw 2.0
output application/json
---
payload.items map {
  sku: $.sku,
  ($.qty >= 10)? bulk: true
}
