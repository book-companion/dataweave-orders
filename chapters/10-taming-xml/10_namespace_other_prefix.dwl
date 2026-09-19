%dw 2.0
ns acme http://acme.com/orders
ns wrong http://acme.com/invoices
output application/json
---
{
  byUri:    payload.acme#order.acme#total,
  wrongUri: payload.wrong#order.wrong#total
}
