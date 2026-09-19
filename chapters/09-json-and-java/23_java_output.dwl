%dw 2.0
output application/java
---
{
  id: payload.orderId,
  items: payload.items map { sku: $.sku, qty: $.qty }
}
