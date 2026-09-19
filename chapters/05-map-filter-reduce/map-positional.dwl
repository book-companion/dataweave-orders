%dw 2.0
output application/json
---
{
  amounts: payload.items map $.price * $.qty,
  indexes: payload.items map $$
}
