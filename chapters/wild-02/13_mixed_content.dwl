%dw 2.0
output application/json
---
{
  whole:    payload.note,
  name:     payload.note.name,
  firstRun: payload.note."__text",
  allRuns:  payload.note.*"__text",
  flat:     payload.note.*"__text" joinBy "[name]"
}
