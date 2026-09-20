%dw 2.0
output application/json
---
{ discount: if ((payload.discount != null) and (payload.discount is Number)) payload.discount else 0 }
