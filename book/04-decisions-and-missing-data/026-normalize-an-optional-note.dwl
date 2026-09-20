%dw 2.0
output application/json
var note = trim(payload.notes default "")
---
{ notes: if (isEmpty(note)) "no notes" else note }
