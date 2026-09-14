%dw 2.0
output application/json
---
{
  descendItem:   payload..item,
  descendName:   payload..customer,
  descendStar:   payload..*item,
  jsonDescend:   read('{"items":[{"sku":"PEN-01"},{"sku":"PAD-22"}]}', "application/json")..sku
}
