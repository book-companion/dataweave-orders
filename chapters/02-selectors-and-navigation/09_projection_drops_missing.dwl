%dw 2.0
output application/json
---
{
  withGaps: [ { sku: "PEN-01", note: "gift" }, { sku: "PAD-22" }, { sku: "CLP-08", note: null } ].note,
  starWithGaps: [ { sku: "PEN-01", note: "gift" }, { sku: "PAD-22" }, { sku: "CLP-08", note: null } ].*note,
  count: sizeOf([ { sku: "PEN-01", note: "gift" }, { sku: "PAD-22" } ].note)
}
