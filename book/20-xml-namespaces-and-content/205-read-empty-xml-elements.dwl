%dw 2.0
output application/json
var xml = "<order><coupon/><note></note><customer>Dana</customer></order>"
---
{
  defaultRead: read(xml, "application/xml"),
  none:        read(xml, "application/xml", { nullValueOn: "none" })
}
