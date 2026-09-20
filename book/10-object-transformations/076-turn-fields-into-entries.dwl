%dw 2.0
output application/json
---
payload pluck (value, key, index) -> { name: key as String, value: value, position: index }
