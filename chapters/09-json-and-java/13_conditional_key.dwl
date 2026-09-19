%dw 2.0
output application/json
---
payload.items map {
  sku: $.sku,
  (note: $.note) if ($.note != null),
  (bulk: true) if ($.qty >= 10)
}
