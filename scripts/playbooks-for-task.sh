#!/usr/bin/env bash
# CommitMind Cursor beforeMCPExecution hook: surfaces ranked playbooks when a
# task is being created (tool_name=task_create). Logic lives in
# `commitmind hook cursor-playbooks-for-task` (Go subcommand), which emits
# Cursor's {"permission":"allow","agent_message":"<nudge>"} on hits and {} otherwise.
#
# Silent-allow ({}) when the commitmind binary isn't on PATH.
if ! command -v commitmind >/dev/null 2>&1; then
    printf '{}'
    exit 0
fi
exec commitmind hook cursor-playbooks-for-task
