%dw 2.0
import entrySet from dw::core::Objects
output application/json
var xml = read("<order id=\"A-1001\"><customer>Dana</customer></order>", "application/xml")
---
entrySet(xml)
