%dw 2.0
output application/json
---
{
  qtyIsNumber: payload.items[0].qty is Number,
  skuIsString: payload.items[0].sku is String,
  itemsIsArray: payload.items is Array,
  itemIsObject: payload.items[0] is Object,
  stringNotNumber: "42" is Number,
  missingIsNull: payload.coupon is Null,
  everythingIsAny: payload.items[0].qty is Any,
  typedArray: [1, 2, 3] is Array<Number>,
  mixedArray: [1, "2", 3] is Array<Number>
}
