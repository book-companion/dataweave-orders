%dw 2.0
import sumBy from dw::core::Arrays
fun lineTotal(item) = item.price * item.qty
fun orderTotal(items) = items sumBy (i) -> lineTotal(i)
