# The Council of Magic Users

Global opencode configuration, overhauled and themed as a council of magic users. Every agent file states its **Official Role** (plain-English functional contract) and its **Role-play** layer (the fantasy persona it performs — the agent knows it is a role, and the role never overrides its real function).

## Roster

| Member | Official role | Mode | Plays |
|---|---|---|---|
| `archmage` | build agent — primary coder (default agent) | primary | The Archmage |
| `oracle` | research & writing agent | primary | The Oracle |
| `plan` | read-only planning agent (built-in override, powers plan mode) | primary | The Strategist |
| `arcane-inquirer` | deep research subagent | subagent | The Arcane Inquirer |
| `thaumaturge` | code-review subagent | subagent | The Thaumaturge |
| `sentinel` | verification subagent | subagent | The Sentinel |

The three subagents are delegation-only: they don't appear in the primary picker; archmage/oracle call them via the Task tool, or you can @-mention them.

## Summoning

- **Tab** — cycle primary agents: archmage → oracle → plan
- **@-mention** — invoke any subagent from a message
- **Slash commands**:
  - `/research <topic>` — the Oracle writes a grounded long-form report
  - `/review` — the Thaumaturge reviews the current changes (evidence, root cause, severity)
  - `/verify` — the Sentinel checks the work actually runs

## Prompt library (`prompts/`)

19 verbatim extracted system prompts from AI labs (CL4R1T4S), deduplicated to the strongest per use case. Indexed in `prompts/INDEX.md`; registered as the `prompts` reference so it is @-mentionable. Skills and agents point at these files for full-fidelity context on demand — baseline sessions stay lean, deep tasks get the full original guidance.

- `coding/` — Claude Code, Cursor, Windsurf, Devin, Cline, Codex, DROID, Manus, Same Dev
- `research/` — Perplexity Deep Research, Gemini 2.5 Pro, ChatGPT 5, Grok team
- `design/` — Claude Design, UserStyle modes
- `webapp/` — v0, Bolt, Lovable

## Skills (`skill/`)

Loaded automatically; agents surface them by their descriptions:
`code-review` · `deep-research` · `git-pr-workflow` · `terminal-workflow` · `ui-design` · `db-migrations`

## Global rules (`AGENTS.md`)

The council's binding laws, loaded every session via `instructions`: concise communication, verify-before-claiming-done, root-cause-not-symptoms, grounded research writing. Kept deliberately plain — whimsy lives in the members' output voice, not in the law.

## How to extend

- New agent: `agent/<name>.md` with frontmatter (`description`, `mode`, `model`, `permission`) + Official Role + Role-play sections.
- New skill: `skill/<name>/SKILL.md` with a front-loaded `description` (what it does AND when to trigger).
- New command: `command/<name>.md` with `description`, optional `agent`, and `$ARGUMENTS` in the body.
- New raw prompt: drop the file into the right `prompts/` family and add one line to `prompts/INDEX.md`.

Config is loaded at startup — after changes, quit and restart opencode.
