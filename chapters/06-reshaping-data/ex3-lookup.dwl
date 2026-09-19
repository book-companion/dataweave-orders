%dw 2.0
output application/json
---
{ ((payload distinctBy (line) -> line.sku) map (line) -> { (line.sku): line.name }) }
