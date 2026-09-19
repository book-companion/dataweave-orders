%dw 2.0
output application/xml
---
{
  order @(id: payload.orderId): {
    (payload.items map {
      item @(sku: $.sku): $.qty
    })
  }
}
