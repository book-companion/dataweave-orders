#!/bin/sh
# Interleaved timing of streaming vs non-streaming map, twice each, after one
# warm-up read of the input (the first read over the bind mount is cold).
cd "$(dirname "$0")"; BIG=chapters/15-streaming-and-performance/big/orders-400000.json
docker run --rm --platform linux/amd64 -v "$(cd ../..; pwd)":/lab --entrypoint sh dw-cli:2.12.0 -c "cat /lab/$BIG > /dev/null"
for i in 1 2; do
  for n in 05_map_streaming 06_map_nostream; do
    ./mem.sh 512m $n $BIG > $n.run$i.out
    printf 'run%s %-20s %s\n' $i "$n" "$(grep -o 'exit=[0-9]*\|peak_bytes=[0-9]*\|elapsed_s=[0-9.]*\|out_bytes=[0-9]*' $n.run$i.out | tr '\n' ' ')"
  done
done
