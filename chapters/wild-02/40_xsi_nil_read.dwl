%dw 2.0
output application/json
var xml = '<order xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><coupon xsi:nil="true"/><customer>Dana</customer></order>'
---
{
  coupon:  read(xml, "application/xml").order.coupon,
  attrs:   read(xml, "application/xml").order.coupon.@,
  isNull:  read(xml, "application/xml").order.coupon == null
}
