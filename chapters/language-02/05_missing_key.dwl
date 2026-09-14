%dw 2.0
output application/json
---
{
  address: payload.shippingAddress,
  city: payload.shippingAddress.city,
  typo: payload.cutsomer.email,
  onNumber: payload.shipping.price.amount
}
