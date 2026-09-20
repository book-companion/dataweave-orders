%dw 2.0
ns ord http://shipping.acme.com/orders
import normalizeBatch, report from orders::Feed
output application/json
---
report(normalizeBatch(payload.ord#orderBatch))
