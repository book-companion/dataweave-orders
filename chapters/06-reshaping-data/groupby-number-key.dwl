%dw 2.0
output application/json
---
{
  byQty: (payload groupBy (line) -> line.qty) mapObject (lines, key) -> { (key): lines map $.sku },
  keyTypes: keysOf(payload groupBy (line) -> line.qty) map typeOf($),
  pickByString: (payload groupBy (line) -> line.qty)."4" map $.sku,
  pickByNumber: (payload groupBy (line) -> line.qty)[4]
}
