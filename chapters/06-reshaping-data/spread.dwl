%dw 2.0
output application/json
---
{
  withFlag: { (payload[0]), flagged: true },
  bySku: { (payload map (line) -> { (line.sku): line.qty }) }
}
