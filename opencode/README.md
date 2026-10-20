# OpenCode Configuration

Global opencode configuration. Each agent file states its **Role** as a plain-English functional contract.

## Agents

| Agent | Role | Mode |
|---|---|---|
| `coder` | build agent — primary coder (default agent) | primary |
| `research` | research & writing agent | primary |
| `plan` | read-only planning agent (built-in override, powers plan mode) | primary |
| `researcher` | deep research subagent | subagent |
| `reviewer` | code-review subagent | subagent |
| `verifier` | verification subagent | subagent |

The three subagents are delegation-only: they don't appear in the primary picker; coder/research call them via the Task tool, or you can @-mention them.

## Invoking

- **Tab** — cycle primary agents: coder → research → plan
- **@-mention** — invoke any subagent from a message
- **Slash commands**:
  - `/research <topic>` — the research agent writes a grounded long-form report
  - `/review` — the reviewer checks the current changes (evidence, root cause, severity)
  - `/verify` — the verifier checks the work actually runs

## Prompt library (`prompts/`)

19 verbatim extracted system prompts from AI labs, deduplicated to the strongest per use case. Indexed in `prompts/INDEX.md`; registered as the `prompts` reference so it is @-mentionable. Skills and agents point at these files for full-fidelity context on demand — baseline sessions stay lean, deep tasks get the full original guidance.

- `coding/` — Claude Code, Cursor, Windsurf, Devin, Cline, Codex, DROID, Manus, Same Dev
- `research/` — Perplexity Deep Research, Gemini 2.5 Pro, ChatGPT 5, Grok team
- `design/` — Claude Design, UserStyle modes
- `webapp/` — v0, Bolt, Lovable

## Skills (`skill/`)

Loaded automatically; agents surface them by their descriptions:
`code-review` · `deep-research` · `git-pr-workflow` · `terminal-workflow` · `ui-design` · `db-migrations`

## Global rules (`AGENTS.md`)

Loaded every session via `instructions`: concise communication, verify-before-claiming-done, root-cause-not-symptoms, grounded research writing. Kept deliberately plain.

## How to extend

- New agent: `agent/<name>.md` with frontmatter (`description`, `mode`, `model`, `permission`) + Role section.
- New skill: `skill/<name>/SKILL.md` with a front-loaded `description` (what it does AND when to trigger).
- New command: `command/<name>.md` with `description`, optional `agent`, and `$ARGUMENTS` in the body.
- New raw prompt: drop the file into the right `prompts/` family and add one line to `prompts/INDEX.md`.

Config is loaded at startup — after changes, quit and restart opencode.
