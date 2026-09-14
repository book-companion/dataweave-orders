%dw 2.0
output application/json
var rows = read(payload, "application/csv", { separator: ";" })
---
{
  lines: rows map { sku: $.sku, lineTotal: ($.qty as Number) * (($.price replace "," with ".") as Number) },
  total: sum(rows map (($.qty as Number) * (($.price replace "," with ".") as Number)))
}
