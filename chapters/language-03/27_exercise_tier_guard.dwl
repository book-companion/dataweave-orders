%dw 2.0
output application/json
type Tier = "gold" | "silver" | "bronze"
var tier = "platinum"
---
{ tier: if (tier is Tier) tier else "bronze" }
