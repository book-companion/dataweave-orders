%dw 2.0
output application/json
type Tier = "gold" | "silver" | "bronze"
---
{ tier: "platinum" as Tier }
