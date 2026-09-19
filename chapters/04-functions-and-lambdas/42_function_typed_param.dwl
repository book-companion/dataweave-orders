%dw 2.0
output application/json
fun applyTo(items: Array, f: (Any) -> Any): Array = items map f($)
fun lineTotal(item) = item.price * item.qty
---
{ totals: applyTo(payload.items, lineTotal), skus: applyTo(payload.items, (item) -> item.sku) }
