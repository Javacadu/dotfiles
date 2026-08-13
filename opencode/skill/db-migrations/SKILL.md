---
name: db-migrations
description: Use when creating or reviewing database migrations, schema changes, RLS policies, or writing SQL for a project's database. Encodes data-integrity-first migration discipline. Do NOT use for writing application code or general SQL queries outside migrations.
---

# Database Migrations

Data integrity first. Distilled from the Bolt and Replit prompt families; read `~/.config/opencode/prompts/webapp/bolt.md` §Database rules and `~/.config/opencode/prompts/webapp/lovable.md` for full original guidance.

## Non-negotiables

- DATA INTEGRITY IS THE HIGHEST PRIORITY.
- Never destructive SQL: `DROP`, `DELETE`, or explicit transaction control (`BEGIN`/`COMMIT`/`ROLLBACK`) unless the user explicitly asks.
- ALWAYS enable Row Level Security and write RLS policies for new tables.
- Use the project's migration mechanism — never hand-edit live tables to "fix" data.

## Migration files

- Never diffs: always complete migration files.
- Never modify an existing migration; create a new one with a descriptive, non-numeric name.
- Every migration starts with a plain-English summary block: headline + explanation + numbered sections (New Tables, Security, Changes), detailed enough that a non-technical reader understands it without reading the SQL.
- Column defaults: booleans `false/true`, numbers `0`, strings `''`, timestamps `now()`. Be cautious about defaults that mask problems — sometimes it's better to let an error surface than store wrong data.

## Verification

- Run the migration against a scratch/test DB when possible and confirm the schema.
- Verify constraints, indexes, and RLS policies actually apply before reporting done.
- Report what changed and what the user must do (e.g. run the migration, set env vars).
