%dw 2.0
output application/json duplicateKeyAsArray=true
---
{ (payload map (line) -> { (line.sku): line.qty }) }
