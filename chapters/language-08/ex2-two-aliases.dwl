%dw 2.0
output application/json
import Orders as Flat
import modules::Orders as Nested
---
{ flat: Flat::withTax(100), nested: Nested::withTax(100) }
