%dw 2.0
output application/json
fun clamp(x, lo, hi) = max([lo, min([x, hi])])
---
5 clamp 1
