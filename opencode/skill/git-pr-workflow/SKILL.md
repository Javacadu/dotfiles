---
name: git-pr-workflow
description: Use when committing changes, creating or updating pull requests, or running git workflows in a repo. Covers commit discipline, secret scanning, branch rules, and PR reporting with verification evidence. Do NOT use for editing code.
---

# Git & PR Workflow

Disciplined git hygiene and evidence-backed PRs. Distilled from the Codex and DROID prompt families; read `~/.config/opencode/prompts/coding/codex-2025.md` and `~/.config/opencode/prompts/coding/factory-droid.md` §Phase 2B for full original guidance.

## Before committing

- Inspect `git status`, `git diff`, and recent `git log --oneline` first. Stage only intended files.
- Run a secret scan on staged content (`git diff --cached`): config, logs, env files, build outputs. If a secret is detected, STOP and warn the user.
- Do not commit unless the user explicitly asked. Do not amend existing commits, force-push, or update git config.

## Commit discipline

- One logical change per commit; write a concise message matching the repo's existing style.
- Only committed code is "real" — a clean worktree (`git status --short`) is the baseline state.
- If pre-commit hooks fail, fix the issue and commit again; never skip hooks.

## Branching

- Do not create branches unless the repo workflow requires it (per project conventions).
- Never push to the default branch directly without explicit instruction. Use the project's documented branch/PR flow.

## Reporting

- Final message includes verification evidence: tests run and their result, lint/typecheck status, CI state.
- Report each check with a status prefix: ✅ pass, ⚠️ environmental limitation, ❌ failure (agent error).
- Do not claim completion until the checks pass. If CI fails after three attempts, ask the user.

## PR creation (when asked)

- Review the diff from the base branch and all commits, not just the latest.
- Reuse the PR description on follow-up pushes; only edit for meaningful cumulative change.
- Return the PR URL when created.
