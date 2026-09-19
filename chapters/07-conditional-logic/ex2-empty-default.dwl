%dw 2.0
output application/json
---
{
  withDefault: payload.notes default "no notes",
  withIsEmpty: if (isEmpty(payload.notes)) "no notes" else payload.notes
}
