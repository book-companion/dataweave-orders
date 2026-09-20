#!/bin/sh
# Stop on either an engine error or a changed serialized result.
set -eu
cd "$(dirname "$0")"
task_tmp=$(mktemp -d "$PWD/.golden-check.XXXXXX")
trap 'rm -rf "$task_tmp"' EXIT HUP INT TERM
task_actual="${task_tmp##*/}/actual.json"
./dw.sh run -s --path=book/support/14-modules-and-testing \
  -i payload=book/support/14-modules-and-testing/order.json \
  -f "${1:-book/15-modules-and-checks/134-normalize-order.dwl}" -o "$task_actual"
diff book/15-modules-and-checks/expected-order.json "$task_actual"
echo "golden: OK"
