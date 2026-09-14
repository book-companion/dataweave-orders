%dw 2.0
output application/json
---
{
  even:   ["PEN-01", "PAD-22"] zip [2.5, 6.0],
  uneven: ["PEN-01", "PAD-22", "CLP-08"] zip [2.5, 6.0],
  toObject: { (["PEN-01", "PAD-22"] zip [2.5, 6.0] map { ($[0]): $[1] }) }
}
