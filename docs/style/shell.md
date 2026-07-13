Shell scripts should be tab-indented, that is to allow indented heredoc's in scripts.

Base Guidelines:

- `#!/usr/bin/env ...`
- `set -euo pipefail`.
- Avoid pipeline subshells to maintain shell state where it might be expected. (`while consumer; do :; done < <(iterator)` instead of `iterator | while consumer; do :; done`).
- Use NUL-separated streams for lists (especially filename ones) where possible.
- Quote all variables.
- Don't assume resources, prefer shell-allocated ones (e.g. `exec {foo}<>...` instead of `exec 42<>..`; `${TMPDIR:-/tmp}` instead of `$tmp`, etc).
- Prefer herestrings/heredocs/redirects/FDs/etc instead of `echo`ing/`cat`ing/`mktemp`ing around when its unnecessary.
- Sanity, use functions and local variables for separation of intent.
- Avoid unnecessary bashisms.
