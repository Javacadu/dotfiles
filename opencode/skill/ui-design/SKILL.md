---
name: ui-design
description: Use when building or improving UI — frontend components, web pages, mockups, prototypes, or pixel-fidelity clones. Encodes anti-slop design rules, component conventions, and accessibility. Do NOT use for backend or non-UI code.
---

# UI Design

Professional, non-generic UI. Distilled from the Claude Design, v0, Lovable, and Gemini prompt families; read `~/.config/opencode/prompts/design/claude-design.md`, `~/.config/opencode/prompts/webapp/v0.md`, and `~/.config/opencode/prompts/webapp/lovable.md` for full original guidance.

## Anti-slop rules

- Every element must earn its place. No filler content, no decorative data ("data slop"), no invented stats.
- Avoid AI-trope aesthetics: aggressive gradients, emoji, rounded-corner containers with a left-border accent, overused fonts (Inter, Roboto, Arial, Fraunces).
- In hi-fi work, a placeholder is better than a bad attempt at the real thing.
- Avoid inventing colors from scratch; use the project's design system or brand colors, else a coherent palette (e.g. oklch).
- Do not default to indigo/blue unless the user asks. Match existing components.

## Component conventions

- shadcn/ui + Tailwind + lucide-react icons by default; recharts for charts.
- Always responsive. Semantic HTML (`main`, `header`), correct ARIA roles, `sr-only` where needed, alt text on non-decorative images.
- No `alert()`; use in-page message components. No `scrollIntoView` hacks.
- Import from existing components; prefer editing over regenerating defaults.

## Workflow

- Ask clarifying questions before starting ambiguous work — better to ask too many than too few; offer "Explore a few options" and "Decide for me" as choices.
- Show work early and iterate. Version files by copy ("v2") rather than overwriting previous states.
- Keep files under ~1000 lines; split into smaller components.
- For pixel-fidelity clones: scrape the live site for exact tokens (hex, spacing, radii); the tree is a menu, not the meal.
- Verify the result loads cleanly and renders; don't self-certify without checking.

## Communication

- Summarize changes briefly after edits; name what changed, not the tools used.
- No emojis unless the design system uses them.
