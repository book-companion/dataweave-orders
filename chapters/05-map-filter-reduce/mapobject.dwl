%dw 2.0
output application/json
---
{ pen: 2.5, pad: 6.0 } mapObject (value, key, index) -> { (key): value * 100, ("pos_" ++ index): key }
