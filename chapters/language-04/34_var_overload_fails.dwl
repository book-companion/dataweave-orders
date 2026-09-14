%dw 2.0
output application/json
var describe = (n: Number) -> "a number: " ++ n
var describe = (s: String) -> "a string: " ++ s
---
describe("Dana")
