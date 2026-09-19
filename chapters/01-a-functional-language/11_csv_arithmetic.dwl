%dw 2.0
output application/json
---
{
  totals: payload map ($.price * $.qty),
  concat: payload map ($.price ++ $.qty)
}
