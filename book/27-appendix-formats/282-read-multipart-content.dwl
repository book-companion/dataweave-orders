%dw 2.0
output application/json
var form = read(payload, "multipart/form-data", { boundary: "boundary42" })
---
{
  partNames:   keysOf(form.parts) map ($ as String),
  orderId:     form.parts.orderId.content,
  disposition: form.parts.items.headers."Content-Disposition",
  contentType: form.parts.items.headers."Content-Type",
  rows:        form.parts.items.content map { sku: $.sku, qty: $.qty as Number }
}
