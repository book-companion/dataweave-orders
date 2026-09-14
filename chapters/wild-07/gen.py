#!/usr/bin/env python3
"""Generate a large JSON array of orders for the streaming probes.
Usage: python3 gen.py <count>   -> big/orders-<count>.json  (gitignored)
Each order is ~250 bytes, so 400000 orders is ~100 MB."""
import json, os, sys
LAB = os.path.dirname(os.path.abspath(__file__))
n = int(sys.argv[1]) if len(sys.argv) > 1 else 400000
skus = ["PEN-01", "PAD-22", "CLP-08"]
names = ["Dana", "Ravi", "Mei", "Tomas"]
out = os.path.join(LAB, "big", f"orders-{n}.json")
os.makedirs(os.path.dirname(out), exist_ok=True)
with open(out, "w") as f:
    f.write("[")
    for i in range(n):
        qty = (i % 7) + 1
        price = [2.5, 6.0, 1.0][i % 3]
        o = {"orderId": f"A-{1001 + i}", "customer": names[i % 4],
             "items": [{"sku": skus[i % 3], "price": price, "qty": qty},
                       {"sku": skus[(i + 1) % 3], "price": [2.5, 6.0, 1.0][(i + 1) % 3], "qty": 1}],
             "total": round(price * qty + [2.5, 6.0, 1.0][(i + 1) % 3], 2)}
        if i: f.write(",")
        f.write(json.dumps(o, separators=(",", ":")))
    f.write("]")
print(out, os.path.getsize(out), "bytes")
