%dw 2.0
import * from dw::core::Arrays
output application/json
---
{ year: |2026-09-13|.year, taken: (payload.items take 2).sku, takenPastEnd: (payload.items take 10).sku }
