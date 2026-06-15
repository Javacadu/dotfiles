# Tmux + Neovim + OpenCode Workflow

This document describes the tmux workflow, session management, and how everything integrates.

## Quick Start

After any change to this file or `.tmux.conf`, reload tmux:

```bash
# Reload tmux config (from inside tmux)
tmux source-file ~/.tmux.conf

# Or from terminal (no tmux needed)
tmux source-file ~/.tmux.conf
```

Install TPM plugins after adding new plugins:

```bash
# Inside tmux, press: prefix + I (capital I)
# prefix = Ctrl-s
# This installs: catppuccin, vim-tmux-navigator, tmux-resurrect, tmux-continuum
```

## Session Management

### Starting a New Dev Session

```bash
# Load the default dev workspace
tmuxp load dev

# Load a project-specific session (when created)
tmuxp load <project-name>

# Load a session from a specific file
tmuxp load ~/.config/tmuxp/dev.yaml
```

### Useful tmuxp Commands

```bash
tmuxp ls              # List saved sessions
tmuxp freeze <name>   # Freeze current session to config file
tmuxp load -S <name>  # Load and switch to session
tmuxp load -d <name>  # Load session in detached mode
```

### Session Persistence (tmux-resurrect + continuum)

Sessions are automatically saved and restored:

- **Auto-save**: Every 15 minutes (continuum)
- **Auto-restore**: On tmux server start (continuum)
- **Manual save**: `Ctrl-s + S` (custom tmux-resurrect keymap)
- **Manual restore**: `Ctrl-s + R` (custom tmux-resurrect keymap)

Keymaps are **customized** in this config:

| Action | Keymap |
|--------|--------|
| Save session | `prefix + S` |
| Restore session | `prefix + R` |

> **Note**: If keymaps feel wrong after a reload, verify tmux isn't overriding them.
> Run `tmux list-keys | grep resurrect` to check.

## Current Config

### `.tmux.conf` Features

| Feature | Plugin | Notes |
|---------|--------|-------|
| Prefix key | — | `Ctrl-s` (replaces default `Ctrl-b`) |
| Pane navigation | vim-tmux-navigator | `<C-h/j/k/l>` works across nvim AND tmux |
| Catppuccin theme | catppuccin/tmux | Flavor: mocha (dark) |
| Session save/restore | tmux-resurrect | Saves pane contents + running programs |
| Auto-restore | tmux-continuum | Restores on tmux server boot |

### Pane Navigation

With `christoomey/vim-tmux-navigator`, these work seamlessly between nvim and tmux:

| Keymap | Action |
|--------|--------|
| `<C-h>` | Move to left pane/window |
| `<C-j>` | Move down |
| `<C-k>` | Move up |
| `<C-l>` | Move right |
| `<C-\>` | Move to last pane |

**Note**: These override native tmux pane navigation. If you need tmux's native behavior,
fall back to `prefix + h/j/k/l`.

### Reload Config

```bash
# Shortcut (already bound in .tmux.conf)
Ctrl-s + r
```

## Directory Structure

```
~/.config/tmuxp/
├── dev.yaml           # Default dev session (nvim + opencode + shell)
└── README.md          # This file
```

## Adding Project-Specific Sessions

### When to Create a Project Config

Create a new tmuxp config when:
- You work on a specific project regularly
- The project needs different panes/commands (e.g., a dev server)
- You want to restore the exact workspace state

### How to Create a Project Config

**Option 1: Freeze an existing session**

```bash
# 1. Manually set up your tmux workspace (splits, windows, commands)
# 2. Freeze it to a config file
tmuxp freeze myproject

# This creates ~/.config/tmuxp/myproject.yaml
```

**Option 2: Write manually**

```bash
# Create ~/.config/tmuxp/myproject.yaml
```

Example for a web project:

```yaml
session_name: myproject
start_directory: ~/path/to/myproject

windows:
  - window_name: editor
    layout: main-horizontal
    focus: true
    panes:
      - shell: nvim

  - window_name: dev
    layout: main-horizontal
    panes:
      - shell: npm run dev

  - window_name: shell
    layout: tiled
    panes:
      - shell: ~
```

Example for a Go project:

```yaml
session_name: mygoapp
start_directory: ~/go/src/github.com/user/mygoapp

windows:
  - window_name: editor
    layout: main-horizontal
    focus: true
    panes:
      - shell: nvim

  - window_name: tests
    layout: main-horizontal
    panes:
      - shell: go test ./...

  - window_name: opencode
    layout: main-horizontal
    panes:
      - shell: opencode

  - window_name: shell
    layout: tiled
    panes:
      - shell: ~
```

**Option 3: Template-based**

Use the `dev.yaml` as a starting point:

```bash
cp ~/.config/tmuxp/dev.yaml ~/.config/tmuxp/myproject.yaml
# Edit the file, then:
tmuxp load myproject
```

### Loading a Project Session

```bash
# Load and attach
tmuxp load myproject

# Load in background (don't attach)
tmuxp load -d myproject

# Load multiple
tmuxp load dev myproject
```

### Startup Behavior (continuum)

With `tmux-continuum` enabled, the last session is restored automatically when tmux starts:

```bash
# If continuum is working, starting tmux will auto-restore your last session
tmux
```

To disable auto-boot (if unwanted):

```bash
# In .tmux.conf, change:
set -g @continuum-boot 'off'
# Then reload tmux config
```

## tmuxp + Neovim + opencode Integration

### Default Layout

The `dev.yaml` config creates:

```
Window 1: editor
  └── Pane: shell (home dir, focused)

Window 2: opencode
  └── Pane: opencode CLI

Window 3: server
  └── Pane: shell (home dir)
```

### With Neovim (in editor pane)

1. Start tmux: `tmuxp load dev`
2. In the editor pane: `nvim`
3. In the opencode pane: `opencode` (or press `<leader>9s` / `<leader>9v` from within nvim to use 99)

### Live Reload

When opencode edits a file:
- **In opencode pane**: changes are written to disk immediately
- **In nvim pane**: the file auto-reloads via `autoread = true` + `checktime` autocmd
- Switch panes with `<C-h>` / `<C-l>` to see live updates

### Workflow Diagram

```
┌─────────────────────────────────┐
│         tmux session           │
│                                 │
│  ┌──────────┬──────────────────┤
│  │ editor   │  opencode pane    │
│  │ nvim     │  (AI agent)       │
│  │ (focused)│                  │
│  └──────────┴──────────────────┤
│  │ server/shell                │
│  └─────────────────────────────│
│                                 │
│  <C-h>    <C-l>  navigate      │
│  <C-\>    last pane            │
└─────────────────────────────────┘
```

## tmux Tips

### Detach/Attach

```bash
# Detach from session
Ctrl-s + d

# List sessions
tmux ls

# Attach to a session
tmux attach -t dev

# Kill a session
tmux kill-session -t dev
```

### Window Management

| Action | Keymap |
|--------|--------|
| New window | `Ctrl-s + c` |
| Next window | `Ctrl-s + n` |
| Previous window | `Ctrl-s + p` |
| List windows | `Ctrl-s + w` |
| Kill window | `Ctrl-s + &` |

### Pane Management

| Action | Keymap |
|--------|--------|
| Split horizontal | `Ctrl-s + |` |
| Split vertical | `Ctrl-s + -` |
| Close pane | `Ctrl-s + x` |
| Zoom pane | `Ctrl-s + z` |
| Swap panes | `Ctrl-s + o` |

### Copy Mode (scrolling/searching)

| Action | Keymap |
|--------|--------|
| Enter copy mode | `Ctrl-s + [` |
| Scroll up/down | `vi` keys or arrows |
| Search | `/` (forward), `?` (backward) |
| Exit copy mode | `q` |

### Mouse Mode

Mouse mode is **enabled** (`set -g mouse on`) for pane resizing and selection.
Disable with `set -g mouse off` in `.tmux.conf` if preferred.

## Troubleshooting

### opencode can't edit files (permission issues)

If opencode reports permission errors:
1. Set `OPENCODE_PERMISSION` env var in your shell profile (`~/.zshenv` or `~/.zshrc`):
   ```bash
   export OPENCODE_PERMISSION='{"edit": "allow"}'
   ```
2. Restart your shell or source: `source ~/.zshrc`
3. Then start tmux: `tmuxp load dev`

### tmux-continuum not auto-restoring

```bash
# Check if continuum is running
tmux list-windows -a

# Check continuum status
tmux run-shell 'echo $CONTINUUM_STATUS'

# If broken, manually restore
Ctrl-s + R

# Or reload tmuxp
tmuxp load dev
```

### nvim colors wrong in tmux

Ensure `tmux-256color` terminal is set:

```bash
# In ~/.zshenv or ~/.zshrc:
export TERM=tmux-256color
```

The `.tmux.conf` already sets `set -g default-terminal "tmux-256color"`.

### tmuxp command not found

After homebrew install, you may need to restart your terminal or run:

```bash
source ~/.zshrc
```

Or find the path:
```bash
which tmuxp
# Should be: /opt/homebrew/bin/tmuxp
```

### Resurrect not saving nvim session state

tmux-resurrect can save nvim's session (with `:mksession`):
- Requires `vim.o.sessionoptions` to include `sessions` — this is **not** set in this config by default
- If desired, add to `init.lua`:
  ```lua
  vim.o.sessionoptions = vim.o.sessionoptions .. ',session'
  ```
- Then nvim session will be restored on tmux-resurrect restore
