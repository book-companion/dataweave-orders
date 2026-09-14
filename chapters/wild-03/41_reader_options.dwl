%dw 2.0
output application/json
---
read("sku,qty\nPEN-01,4", "application/csv", { bogus: true })
