%dw 2.0
output application/json
---
{
  unix:    write(payload.items map { sku: $.sku, qty: $.qty }, "application/csv"),
  windows: write(payload.items map { sku: $.sku, qty: $.qty }, "application/csv", { lineSeparator: "\r\n" })
}
