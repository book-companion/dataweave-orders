%dw 2.0
output application/json
fun shout(s: String): String = upper(s) ++ "!"
---
{ fromNumber: shout(42), fromString: shout(payload.customer) }
