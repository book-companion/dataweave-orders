%dw 2.0
output application/json
---
(payload splitBy "\n") filter (!isEmpty($)) map (line) -> {
  customerId:  trim(line[0 to 9]),
  name:        trim(line[10 to 39]),
  amountCents: line[40 to 51] as Number
}
