%dw 2.0
output application/json
type Sku = String
type Tier = "gold" | "silver" | "bronze"
type Price = String | Number
type LineItem = { sku: Sku, price: Number, qty: Number, note?: String }
type Order = { orderId: String, customer: String, items: Array<LineItem> }
---
{
  goldIsTier: "gold" is Tier,
  platinumIsTier: "platinum" is Tier,
  stringPrice: "2.50" is Price,
  numberPrice: 2.5 is Price,
  boolPrice: true is Price,
  firstIsLineItem: payload.items[0] is LineItem,
  wholeIsOrder: payload is Order,
  wrongShape: { sku: "PEN-01", price: "2.50", qty: 4 } is LineItem,
  extraKey: { sku: "PEN-01", price: 2.5, qty: 4, colour: "blue" } is LineItem,
  withNote: { sku: "PEN-01", price: 2.5, qty: 4, note: "gift" } is LineItem
}
