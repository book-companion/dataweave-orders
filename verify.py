#!/usr/bin/env python3
"""Run the whole numbered edition in one instance of the pinned image."""
from pathlib import Path
import subprocess
import sys
root = Path(__file__).resolve().parent
result = subprocess.run([
    'docker', 'run', '--rm', '--network', 'none', '--platform', 'linux/amd64',
    '-v', f'{root}:/lab:ro', '-w', '/lab', '--entrypoint', '/opt/node/bin/node',
    '-e', 'DW_BIN=/opt/dw/bin/dw', 'dw-cli:2.12.0', 'verify-book.mjs',
], cwd=root)
sys.exit(result.returncode)
