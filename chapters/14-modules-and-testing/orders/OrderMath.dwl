%dw 2.0

import sumBy from dw::core::Arrays

type LineItem = { sku: String, price: Number, qty: Number }

/**
 * Extended price for a single line.
 */
fun lineTotal(item: LineItem): Number = item.price * item.qty

/**
 * Total of every line on an order.
 */
fun orderTotal(items: Array<LineItem>): Number =
  items sumBy (i) -> lineTotal(i)
