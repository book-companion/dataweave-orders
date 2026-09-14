%dw 2.0
output application/json
---
{ a: now(), b: now(), same: now() == now() }
