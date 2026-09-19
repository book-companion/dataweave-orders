%dw 2.0
import * from dw::core::Strings
output application/json
---
{
  lines:    lines("PEN-01\nPAD-22"),
  words:    words("premium gift wrap"),
  wrapped:  "A-1001" wrapWith "'",
  unwrapped: "'A-1001'" unwrap "'",
  ensureSuffix: "order" appendIfMissing ".json",
  keepSuffix:   "order.json" appendIfMissing ".json",
  numeric:  isNumeric("1099"),
  alpha:    isAlpha("AC"),
  removed:  "A-1001" remove "-",
  reversed: reverse("PEN-01")
}
