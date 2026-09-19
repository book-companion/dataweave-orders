%dw 2.0
output application/json
---
{
  mixedIsNumbers: [1, "2", 3] is Array<Number>,
  wordIsNumbers: [1, "two", 3] is Array<Number>,
  numbersAreStrings: [1, 2] is Array<String>,
  emptyIsNumbers: [] is Array<Number>,
  objectsAreNumbers: [{ a: 1 }] is Array<Number>
}
