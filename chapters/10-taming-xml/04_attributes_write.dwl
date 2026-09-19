%dw 2.0
output application/xml
---
{
  order @(id: payload.orderId, status: "shipped"): {
    customer: payload.customer,
    (payload.items map {
      item @(sku: $.sku, qty: $.qty): $.sku
    }),
    total @(currency: "USD"): sum(payload.items map ($.price * $.qty))
  }
}
