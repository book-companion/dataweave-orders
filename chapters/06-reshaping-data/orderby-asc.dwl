%dw 2.0
output application/json
---
{
  byPrice: (payload orderBy (line) -> line.price) map $.sku,
  byName:  (payload orderBy (line) -> line.name)  map $.name
}
