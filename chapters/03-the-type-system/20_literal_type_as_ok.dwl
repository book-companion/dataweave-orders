%dw 2.0
output application/json
type Tier = "gold" | "silver" | "bronze"
---
{ tier: "gold" as Tier, typeName: typeOf("gold" as Tier) }
