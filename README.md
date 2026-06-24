# CommitMind for Cursor

Deterministic project memory, indexed code-intelligence (`xref`), and task / playbook
workflows for Cursor — packaged as a [Cursor plugin](https://cursor.com/docs/reference/plugins).

It is the Cursor sibling of the CommitMind Claude Code, Codex, and OpenCode plugins.

## Prerequisite

The [`commitmind` CLI](https://commitmind.dev) must be installed and authenticated
(`commitmind init`). The plugin's MCP servers and hooks delegate to it; the local
daemon is the source of truth.

## What's included

- **`mcp.json`** — two MCP servers:
  - `commitmind` — memory + task tools (`prime_session`, `search_memory`,
    `recent_activity`, the `task_*` family, `log_observation`, `promote_decision`,
    capability docs, learnings, playbooks, …).
  - `commitmind-code` — indexed code tools (`xref`, `get_rules_for_this_file`,
    `check_rules`, `review_changes`, …).
- **`rules/`** — routing rules (`.mdc`) that steer the agent to the right tool:
  code-routing (xref over grep), memory-routing (the WHY layer), playbook-routing,
  review-routing, parallel-worktree, plus an always-on **prime** rule that asks the
  agent to call `prime_session` at session start.
- **`commands/`** — `/review`, `/fix`, `/rule`.
- **`hooks/`** — deterministic gates (see below).

## A note on hooks (current Cursor limitations)

CommitMind's Claude Code plugin uses hooks heavily to *inject context* (prime,
WHY-context before edits, ranked playbooks). In current Cursor, the hook
`additional_context` channel is **broken upstream** (sessionStart + postToolUse
`additional_context` is accepted but not surfaced to the model — Cursor forum
#158452 / #158168, open as of mid-2026). So this plugin deliberately:

- moves context injection into **always-on / agent-requested rules** instead of hooks, and
- ships only **deterministic deny-gates** as hooks — the documented `permission: "deny"`
  + `agent_message` path that Cursor *does* honor (e.g. block "task done" with
  uncommitted changes; redirect grep→`xref`).

Dynamic per-event injection will be revisited once Cursor closes those tickets.

## Install

From the Cursor Marketplace (once published), or by adding the repository directly.
The `commitmind` CLI must be installed first.
