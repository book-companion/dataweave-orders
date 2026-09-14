%dw 2.0
output application/json
fun describe(n: Number) = "a number: " ++ n
fun describe(s: String) = "a string: " ++ s
fun describe(a: Array) = "an array of " ++ sizeOf(a)
---
[ describe(2.5), describe(payload.customer), describe(payload.items) ]
