#!/bin/sh
# Regenerates every *.out in this folder from `manifest`. Usage: ./run.sh [probe.dwl]
exec "$(dirname "$0")/../run-chapter.sh" "$0" "$@"
