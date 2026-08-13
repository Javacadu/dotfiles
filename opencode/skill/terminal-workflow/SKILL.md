---
name: terminal-workflow
description: Use when running shell commands in a project — especially long-running servers, package installs, or anything that could prompt interactively or page output. Encodes command ergonomics: cwd instead of cd, non-interactive flags, pager handling, and backgrounding. Do NOT use for editing files.
---

# Terminal Workflow

Clean, non-interactive shell discipline. Distilled from the Cursor, Windsurf, and Same Dev prompt families; read `~/.config/opencode/prompts/coding/cursor-2.0.md` and `~/.config/opencode/prompts/coding/windsurf.md` for full original guidance.

## Command ergonomics

- Run commands in the target directory via the workdir parameter. NEVER `cd` inside the command when a workdir exists.
- Assume the user is unavailable: pass non-interactive flags (`npm ci --no-fund --no-audit`, `yes | apt-get`), avoid prompts.
- Append `| cat` to anything that pages (git log, less, head). Prefer explicit output limits (`git log -n 5`).
- Chain dependent commands with `&&`; separate independent commands into their own calls.
- No newlines inside a single command unless inside a quoted string.

## Long-running processes

- Background long-running jobs (dev servers, watchers) explicitly; do not block the session on them.
- After starting a local web server, verify it's actually serving before telling the user.
- Know the difference between "submitted" and "completed": a command awaiting approval has NOT started running.

## Safety

- Never auto-run destructive commands: deletes, state mutation, system dependency installs, external requests. Ask first.
- Avoid `ls -R` and `grep -R`; use the project-aware search tools instead.
- Track cwd via the session, not by guesswork. When in doubt, re-run `pwd` or use absolute paths.
