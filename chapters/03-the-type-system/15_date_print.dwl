%dw 2.0
output application/json
---
{
  iso: |2026-09-13| as String {format: "yyyy-MM-dd"},
  friendly: |2026-09-13| as String {format: "dd MMM yyyy"},
  long: |2026-09-13| as String {format: "EEEE, d MMMM yyyy"},
  plain: |2026-09-13| as String
}
