%dw 2.0
output application/json
---
read('<order id="A-1001"/>', "application/json")
