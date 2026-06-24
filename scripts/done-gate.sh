#!/usr/bin/env bash
# CommitMind Cursor beforeMCPExecution hook: blocks marking a task done
# (task_complete, or task_advance with to_phase=done) while files edited
# under that task still have uncommitted changes. Logic lives in
# `commitmind hook cursor-done-gate` (Go subcommand), which emits Cursor's
# {"permission":"deny","agent_message":"<reason>"} on a block and {} otherwise.
# Uses Cursor's DOCUMENTED deny + agent_message channel. Override with
# COMMITMIND_DONE_GATE=off.
#
# Silent-allow ({}) when the commitmind binary isn't on PATH.
if ! command -v commitmind >/dev/null 2>&1; then
    printf '{}'
    exit 0
fi
exec commitmind hook cursor-done-gate
