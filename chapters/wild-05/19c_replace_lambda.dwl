%dw 2.0
output application/json
---
{
  lambdaGroup:  "AC-1099" replace /(\d+)/ with ((m) -> "[" ++ m[1] ++ "]"),
  lambdaFull:   "PEN-01, PAD-22" replace /[A-Z]+/ with ((m) -> lower(m[0])),
  interpolated: "AC-1099" replace /(\d+)/ with "[$($[1])]",
  literal:      "AC-1099" replace /(\d+)/ with "[]"
}
