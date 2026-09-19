%dw 2.0
output application/json
---
{
  orderId: payload.orderId,
  placed: (payload.placed as Date {format: "dd/MM/yyyy"}) as String {format: "yyyy-MM-dd"},
  total: sum(payload.items map (($.price as Number) * ($.qty as Number))) as String {format: "0.00"}
}
