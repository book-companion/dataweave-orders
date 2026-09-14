#!/bin/sh
# Chapter 8 (composing and modules) — runs every probe in this folder against its input
# and writes <probe>.out beside it (ANSI and JVM warnings stripped). Run from anywhere.
# Module probes resolve Orders.dwl / modules/Orders.dwl / BodyModule.dwl from this folder via --path.
HERE="$(cd "$(dirname "$0")" && pwd)"; LAB="$(cd "$HERE/../.." && pwd)"; REL="chapters/$(basename "$HERE")"
cd "$LAB" || exit 1
input_for() {
  case "$1" in
    input-csv*|input-mismatch) echo "$REL/lines.csv" ;;
    *) echo "$REL/orders.json" ;;
  esac
}
extra_for() {
  case "$1" in
    use-module-nopath) echo "" ;;
    use-*|ex*|do-inline) echo "--path=$REL" ;;
    params) echo "--path=$REL -p rate=0.2" ;;
    *) echo "" ;;
  esac
}
for p in "$HERE"/*.dwl; do
  n=$(basename "$p" .dwl)
  case "$n" in BodyModule|OutModule) continue ;; esac
  in=$(input_for "$n"); extra=$(extra_for "$n")
  case "$n" in input-literal*)   # literal input on the command line, no file
    lit='payload={"orderId":"A-1001","items":[{"sku":"PEN-01","price":2.5,"qty":4}]}'
    { echo "\$ dw run -li '$lit' -f $REL/$n.dwl"; ./dw.sh run -s -li "$lit" -f "$REL/$n.dwl" 2>&1; rc=$?; echo; echo "exit=$rc"; } \
      | sed -E 's/\x1b\[[0-9;]*m//g' | grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated" > "$HERE/$n.out"
    printf '%-32s %s\n' "$n" "$(grep -o 'exit=[0-9]*' "$HERE/$n.out")"; continue ;;
  esac
  { echo "\$ dw run -i payload=$in $extra -f $REL/$n.dwl"; ./dw.sh run -s -i "payload=$in" $extra -f "$REL/$n.dwl" 2>&1; rc=$?; echo; echo "exit=$rc"; } \
    | sed -E 's/\x1b\[[0-9;]*m//g' | grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated" > "$HERE/$n.out"
  printf '%-32s %s\n' "$n" "$(grep -o 'exit=[0-9]*' "$HERE/$n.out")"
done
