%dw 2.0
output application/json
---
payload.items filter ($.qty >= 4) map $.sku
