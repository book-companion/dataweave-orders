%dw 2.0
ns ord http://shipping.acme.com/orders
import fail from dw::Runtime
fun parseDate(s: String): Date =
  if (s matches /\d{4}-\d{2}-\d{2}T.*/) (s as DateTime) as Date
  else if (s matches /\d{4}-\d{2}-\d{2}/) s as Date {format: "yyyy-MM-dd"}
  else s as Date {format: "MM/dd/yyyy"}
fun normalizeLine(line) = {
  sku: line.ord#sku,
  category: line.ord#category,
  price: if (line.ord#price.@currency == "USD") line.ord#price as Number else fail("Expected USD price"),
  qty: line.ord#qty as Number
}
fun normalizeOrder(order) = {
  id: order.@id,
  placedAt: parseDate(order.ord#placedAt) as String {format: "yyyy-MM-dd"},
  customer: order.ord#customer,
  tier: order.ord#customer.@tier,
  note: order.ord#note,
  lines: (order.*ord#line default []) map (line) -> normalizeLine(line)
}
fun normalizeBatch(batch) = {
  batchId: batch.@batchId,
  orders: (batch.*ord#order default []) map (order) -> normalizeOrder(order)
}
fun lineTotal(line) = line.price * line.qty
fun receipt(order) = do {
  var lines = order.lines map (line) -> line ++ {lineTotal: lineTotal(line)}
  ---
  {
    id: order.id, placedAt: order.placedAt, customer: order.customer,
    (vip: true) if (order.tier == "gold"),
    (note: order.note) if (order.note != null),
    lines: lines,
    orderTotal: sum(lines map (line) -> line.lineTotal)
  }
}
fun report(batch) = do {
  var orders = batch.orders map (order) -> receipt(order)
  var lines = orders flatMap (order) -> order.lines
  var groups = lines groupBy (line) -> line.category
  ---
  {
    batchId: batch.batchId,
    orders: orders,
    revenueByCategory: groups mapObject (group, category) -> {(category): sum(group map (line) -> line.lineTotal)},
    batchTotal: sum(orders map (order) -> order.orderTotal)
  }
}
