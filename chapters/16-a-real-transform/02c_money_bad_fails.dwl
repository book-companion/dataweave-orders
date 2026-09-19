%dw 2.0
import money from orders::Feed
output application/json
---
money("\$6.00")
