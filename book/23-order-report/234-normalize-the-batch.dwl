%dw 2.0
ns ord http://shipping.acme.com/orders
import normalizeBatch from orders::Feed
output application/json
---
normalizeBatch(payload.ord#orderBatch)
