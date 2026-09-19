#!/bin/sh
# Regenerates every *.out beside its probe. Run from anywhere.
cd "$(dirname "$0")"; DW=../../dw.sh; C=chapters/13-strings-numbers-and-the-stdlib
strip() { sed -E 's/\x1b\[[0-9;]*m//g' | grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated\|Weave Home directory"; }
go() { # go <name> [dw args...]
  n=$1; shift
  { $DW run -s "$@" -f $C/$n.dwl 2>&1; echo "exit=$?"; } | strip > $n.out
  printf '%-32s %s\n' "$n" "$(grep -o 'exit=[0-9]*' $n.out)"
}
J="-i payload=$C/order.json"
for n in $(ls [0-9]*.dwl | sed 's/\.dwl$//'); do go $n $J; done
