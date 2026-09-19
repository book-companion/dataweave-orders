%dw 2.0
output application/json
fun applyTo(items: Array, f: (Any) -> Any): Array = items map f($)
---
applyTo(payload.items, 3)
