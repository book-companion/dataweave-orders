#!/bin/sh
# Chapter 6 (reshaping) — runs every probe in this folder against its input
# and writes <probe>.out beside it (ANSI and JVM warnings stripped). Run from anywhere.
HERE="$(cd "$(dirname "$0")" && pwd)"; LAB="$(cd "$HERE/../.." && pwd)"; REL="chapters/$(basename "$HERE")"
cd "$LAB" || exit 1
input_for() {
  case "$1" in
    flatmap-orders) echo "$REL/orders.json" ;;
    *) echo "$REL/lines.json" ;;
  esac
}
for p in "$HERE"/*.dwl; do
  n=$(basename "$p" .dwl); in=$(input_for "$n")
  { echo "\$ dw run -i payload=$in -f $REL/$n.dwl"; ./dw.sh run -s -i "payload=$in" -f "$REL/$n.dwl" 2>&1; rc=$?; echo; echo "exit=$rc"; } \
    | sed -E 's/\x1b\[[0-9;]*m//g' | grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated" > "$HERE/$n.out"
  printf '%-32s %s\n' "$n" "$(grep -o 'exit=[0-9]*' "$HERE/$n.out")"
done
