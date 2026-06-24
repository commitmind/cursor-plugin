#!/usr/bin/env bash
# CommitMind Cursor beforeShellExecution hook: routes a recursive grep/rg over
# indexed code, or a "memory question wearing git clothes" (git log / git diff
# over a topic), to the indexed CommitMind tools (xref + search_memory). Logic
# lives in `commitmind hook cursor-routing-enforce` (Go subcommand), which emits
# Cursor's {"permission":"deny","agent_message":"<redirect>"} on a hit and {}
# otherwise. Fails open (silent-allow {}) when code-intel is unreachable and on
# a repeated command, so a deny never hard-locks the agent.
#
# Silent-allow ({}) when the commitmind binary isn't on PATH.
if ! command -v commitmind >/dev/null 2>&1; then
    printf '{}'
    exit 0
fi
exec commitmind hook cursor-routing-enforce
