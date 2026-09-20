%dw 2.0
output application/json
---
readUrl("classpath://customers.txt", "application/flatfile", {schemaPath:"customers.ffd"})
