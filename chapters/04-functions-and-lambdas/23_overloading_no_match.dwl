%dw 2.0
output application/json
fun describe(n: Number) = "a number: " ++ n
fun describe(s: String) = "a string: " ++ s
---
describe(true)
