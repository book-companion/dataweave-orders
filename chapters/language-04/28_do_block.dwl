%dw 2.0
output application/json
fun lineSummary(item) = do {
  var gross = item.price * item.qty
  var discounted = gross * 0.9
  ---
  { sku: item.sku, gross: gross, net: discounted }
}
---
payload.items map lineSummary($)
