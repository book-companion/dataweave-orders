%dw 2.0
import * from dw::core::Numbers
output application/json
---
{
  hex:      toHex(255),
  fromHex:  fromHex("ff"),
  binary:   toBinary(10),
  fromBin:  fromBinary("1010"),
  radix:    toRadixNumber(255, 16),
  fromRadix: fromRadixNumber("zz", 36),
  roundStillGlobal: round(2.5)
}
