%dw 2.0
output application/json
---
((payload orderBy (line) -> -line.qty) orderBy (line) -> line.category) map ($.category ++ ":" ++ $.qty)
