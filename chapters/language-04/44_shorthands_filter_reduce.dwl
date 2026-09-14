%dw 2.0
output application/json
---
{
  bulk: payload.items filter $.qty >= 4 map $.sku,
  total: payload.items reduce ((item, acc = 0) -> acc + item.price * item.qty)
}
