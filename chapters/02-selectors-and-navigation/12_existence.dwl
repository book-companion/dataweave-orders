%dw 2.0
output application/json
---
{
  hasEmail: payload.customer.email?,
  hasPhone: payload.customer.phone?,
  nullValueCounts: { coupon: null }.coupon?,
  deepMissing: payload.warehouse.bay?,
  indexExists: payload.items[2]?,
  indexMissing: payload.items[3]?
}
