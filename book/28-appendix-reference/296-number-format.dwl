%dw 2.0
output application/json
---
{
  thousands: 1234.5 as String {format: "#,###.00"},
  twoPlaces: (2.5 * 4) as String {format: "0.00"},
  optionalDecimals: 10 as String {format: "#.##"},
  rounded: 12.4966 as String {format: "0.00"},
  parsedBack: "1,234.50" as Number {format: "#,###.00"},
  total: sum(payload.items map ($.price * $.qty)) as String {format: "0.00"}
}
