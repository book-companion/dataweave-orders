%dw 2.0
output application/json
var xml = '<order id="A-1001"><customer>Dana</customer></order>'
---
{
  parsed:    read(xml, "application/xml"),
  asJson:    write(read(xml, "application/xml"), "application/json", { indent: false }),
  asXml:     write({ order: { id: payload.orderId } }, "application/xml", { writeDeclaration: false, indent: false }),
  asCsv:     write(payload.items, "application/csv"),
  typeOfWrite: typeOf(write(payload, "application/json")) as String
}
