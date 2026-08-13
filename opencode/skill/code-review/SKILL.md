---
name: code-review
description: Use when reviewing code changes, diffs, pull requests, or pre-commit code quality checks. Provides a structured review contract: evidence-based findings, root-cause analysis, severity-ranked issues. Do NOT use for writing new code or implementing features.
---

# Code Review

Review with evidence, not vibes. Distilled from the Devin, DROID, and Cline prompt families; read `~/.config/opencode/prompts/coding/factory-droid.md` §Phase 2A and `~/.config/opencode/prompts/coding/devin-2025.md` for full original guidance.

## Procedure

1. Gather full context first: the diff, the surrounding files, the tests, the intended behavior. Never review code you haven't opened.
2. Consider that a failing test's root cause may be the code under review, not the test.
3. Check the verification gates: tests pass, lint/typecheck clean, no secrets staged. `git diff --cached` scan for credentials/API keys before any push.

## Output format

Structure findings as:

- **Findings** — evidence-based, each with exact file:line citations and a minimal snippet.
- **Root Cause** — the underlying issue, not the symptom.
- **Fix Options** — ranked options with tradeoffs, not a single mandate.
- **Next Steps** — what the author should do, in order.

## Severity rules

- Blocking issues (broken code, security, data loss, secrets) first.
- Call out code that "pretends to work" — mock data, swallowed errors, skipped tests.
- Distinguish real problems from style preferences; mark preferences as non-blocking.
- If you found no issues, say so plainly and stop. No filler.

## Communication

- Be direct, no hedging, no flattery. Never start with "Great", "Certainly", "Okay", "Sure".
- Never modify code during a review unless explicitly asked. Report only.
- Prefer file:line citations over paraphrased locations.
