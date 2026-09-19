%dw 2.0
output application/json
---
{
  money:     32 as String { format: "0.00" },
  thousands: 1234567.891 as String { format: "#,##0.00" },
  parsed:    "1,234.50" as Number { format: "#,##0.00" },
  padded:    7 as String { format: "000" }
}
