%dw 2.0
output application/json
---
{
  totals: payload.items map $.price * $.qty,
  numbered: payload.items map { line: $$ + 1, sku: $.sku },
  afterFirst: payload.items filter ($$ > 0) map $.sku
}
