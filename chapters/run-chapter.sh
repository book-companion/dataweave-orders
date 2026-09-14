#!/bin/sh
# Shared runner for chapters/wild-NN/run.sh. Reads the folder's `manifest`
# (one probe per line: `<probe.dwl> <input|-> [extra dw args]`), runs each
# probe through ../../dw.sh and writes <probe>.out beside it, ANSI stripped
# and JVM noise removed. Paths in the manifest are relative to the folder.
DIR="$(cd "$(dirname "$1")" && pwd)"; cd "$DIR" || exit 1
LAB="$(cd ../.. && pwd)"; REL="chapters/$(basename "$DIR")"
[ -n "$2" ] && ONLY="$2"
while read -r probe input extra; do
  case "$probe" in ''|'#'*) continue ;; esac
  [ -n "$ONLY" ] && [ "$probe" != "$ONLY" ] && continue
  n="${probe%.dwl}"
  in=""; [ "$input" != "-" ] && in="-i payload=$REL/$input"
  ex=""; [ -n "$extra" ] && ex="$(printf '%s' "$extra" | sed "s#@#$REL/#g")"
  { "$LAB/dw.sh" run -s $in -f "$REL/$probe" $ex 2>&1; echo "exit=$?"; } \
    | LC_ALL=C sed -E 's/\x1b\[[0-9;]*m//g' | LC_ALL=C grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated" > "$n.out"
  printf '%-36s %s\n' "$n" "$(grep -o 'exit=[0-9]*' "$n.out")"
done < manifest
