%dw 2.0
output application/json
var rows = [{ sku: "PEN-01", name: "Ballpoint pen, blue" }, { sku: "PAD-22", name: "Notepad \"A5\"" }]
---
{
  defaults:    write(rows, "application/csv"),
  quoteValues: write(rows, "application/csv", { quoteValues: true }),
  rfc4180:     write(rows, "application/csv", { quoteValues: true, escape: "\"" }),
  quoteHeader: write(rows, "application/csv", { quoteValues: true, quoteHeader: true, escape: "\"" })
}
