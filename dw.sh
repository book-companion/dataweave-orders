#!/bin/sh
set -eu
TASK_ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
exec docker run --rm --network none --platform linux/amd64 -v "$TASK_ROOT":/lab -w /lab dw-cli:2.12.0 "$@"
