%dw 2.0
output application/json
---
payload map (order) -> do {
  var placed = order.placed as LocalDateTime {format: "dd/MM/yyyy HH:mm"}
  ---
  {
    id:       order.id,
    placedAt: placed as String {format: "yyyy-MM-dd'T'HH:mm"},
    shipBy:   (placed + |P2D|) as String {format: "yyyy-MM-dd"}
  }
}
