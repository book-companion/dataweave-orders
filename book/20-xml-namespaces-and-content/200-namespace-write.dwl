%dw 2.0
ns ord http://acme.com/orders
output application/xml
---
{
  ord#order @(id: "A-1001"): {
    ord#customer: "Dana",
    ord#total @(currency: "USD"): 32.00
  }
}
