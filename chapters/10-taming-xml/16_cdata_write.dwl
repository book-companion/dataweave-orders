%dw 2.0
output application/xml
---
{
  item @(sku: "CLP-08"): {
    plain:   payload.item.escaped,
    wrapped: payload.item.escaped as CData
  }
}
