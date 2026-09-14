%dw 2.0
output application/json
---
read(payload, "application/flatfile", { schemaPath: "customers.ffd" }) map {
  orderId: $.customerId,
  name: trim($.name),
  amountCents: $.amount as Number
}
