%dw 2.0
output multipart/form-data boundary="boundary42"
---
{
  parts: {
    orderId: { headers: { "Content-Type": "text/plain" }, content: payload.orderId },
    items:   { headers: { "Content-Type": "application/csv",
                          "Content-Disposition": { name: "items", filename: "items.csv" } },
               content: payload.items map { sku: $.sku, qty: $.qty } }
  }
}
