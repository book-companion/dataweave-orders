%dw 2.0
import parseDate from orders::Feed
output application/json
---
parseDate("16-06-2026")
