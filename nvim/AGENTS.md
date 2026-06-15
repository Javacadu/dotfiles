# Neovim Configuration Agent Guide

This file is auto-loaded by opencode and other AI agents when working in this directory.
Read this before making any changes to the Neovim configuration.

## Overview

This config is based on **kickstart.nvim** — a single-file starting point that the user
has extended. It is NOT a distro. Every line is intentional and readable.

- **Config root**: `~/.config/nvim/`
- **Entry point**: `init.lua` (single file, ~1068 lines)
- **Plugin manager**: lazy.nvim (auto-bootstrapped in init.lua)
- **Lua version**: Neovim's built-in LuaJIT

## Directory Structure

```
~/.config/nvim/
├── init.lua                          # Main config — options, keymaps, plugin setup
├── lazy-lock.json                    # Plugin version lockfile (do not edit manually)
├── lua/
│   ├── kickstart/
│   │   └── plugins/                  # Optional kickstart plugins (all enabled)
│   │       ├── autopairs.lua         # nvim-autopairs
│   │       ├── debug.lua             # nvim-dap + nvim-dap-ui (Go debugger)
│   │       ├── gitsigns.lua          # Extended gitsigns keymaps
│   │       ├── indent_line.lua       # indent-blankline.nvim
│   │       ├── lint.lua              # nvim-lint (markdownlint)
│   │       └── neo-tree.lua          # Neo-tree file explorer
│   └── custom/
│       └── plugins/
│           └── init.lua              # USER plugins — add new plugins HERE
└── scratch/
    └── custom_rules/                 # 99 plugin skill files (type # in 99 prompt)
        └── nvim/
            └── SKILL.md              # This nvim config skill
```

## How to Add a New Plugin

**Always add to `lua/custom/plugins/init.lua`** — never to `init.lua` directly.

The file returns a table of lazy.nvim plugin specs:

```lua
return {
  {
    'author/plugin-name',
    config = function()
      require('plugin-name').setup({})
    end,
  },
  -- more plugins...
}
```

After saving, run `:Lazy sync` in Neovim to install.

**Note**: The `{ import = 'custom.plugins' }` line in `init.lua` is currently commented out
at line 1039. If custom plugins are not loading, uncomment that line.

**Currently**: `lua/custom/plugins/init.lua` is explicitly required at line 997 area via
`require 'kickstart.plugins.neo-tree'` pattern — but custom plugins use a direct require.
Check the bottom of `init.lua` to confirm the import is active.

## How to Edit Existing Plugins

- **Kickstart plugins** (debug, neo-tree, gitsigns, etc.): edit their file in
  `lua/kickstart/plugins/<name>.lua`
- **Core plugins** (telescope, LSP, treesitter, blink.cmp, tokyonight, etc.): configured
  inline in `init.lua` — search by plugin name
- **User plugins**: `lua/custom/plugins/init.lua`

## Plugin Inventory

### AI
| Plugin | Location | Notes |
|--------|----------|-------|
| ThePrimeagen/99 | `lua/custom/plugins/init.lua` | opencode wrapper, keymaps `<leader>9s/v/x` |

### Core Editor
| Plugin | Location | Notes |
|--------|----------|-------|
| folke/lazy.nvim | bootstrapped in `init.lua:234` | Plugin manager |
| NMAC427/guess-indent.nvim | `init.lua:260` | Auto-detects tabstop/shiftwidth |
| folke/tokyonight.nvim | `init.lua:888` | Colorscheme: `tokyonight-night` |
| echasnovski/mini.nvim | `init.lua:913` | mini.ai, mini.surround, mini.statusline |
| nvim-treesitter | `init.lua:958` | Syntax/indent, auto-installs parsers |

### LSP & Completion
| Plugin | Location | Notes |
|--------|----------|-------|
| neovim/nvim-lspconfig | `init.lua:488` | LSP client config |
| mason-org/mason.nvim | dependency of lspconfig | Installs LSP servers |
| mason-org/mason-lspconfig.nvim | dependency of lspconfig | Bridges mason + lspconfig |
| WhoIsSethDaniel/mason-tool-installer | dependency of lspconfig | Ensures stylua installed |
| folke/lazydev.nvim | `init.lua:476` | Lua LSP for Neovim API (ft=lua only) |
| saghen/blink.cmp | `init.lua:790` | Completion engine (replaces nvim-cmp) |
| L3MON4D3/LuaSnip | dependency of blink.cmp | Snippet engine |
| j-hui/fidget.nvim | dependency of lspconfig | LSP status indicator |

### Navigation & Search
| Plugin | Location | Notes |
|--------|----------|-------|
| nvim-telescope/telescope.nvim | `init.lua:371` | Fuzzy finder |
| telescope-fzf-native.nvim | dependency of telescope | Native fzf sorter |
| telescope-ui-select.nvim | dependency of telescope | vim.ui.select via telescope |
| nvim-neo-tree/neo-tree.nvim | `lua/kickstart/plugins/neo-tree.lua` | File tree (`\` to toggle) |
| christoomey/vim-tmux-navigator | `init.lua:1001` | `<C-hjkl>` across tmux/nvim panes |

### Git
| Plugin | Location | Notes |
|--------|----------|-------|
| lewis6991/gitsigns.nvim | `init.lua:284` + `lua/kickstart/plugins/gitsigns.lua` | Gutter signs + keymaps |

### Testing & Debugging
| Plugin | Location | Notes |
|--------|----------|-------|
| vim-test/vim-test | `init.lua:1021` | Test runner (strategy: vimux) |
| preservim/vimux | dependency of vim-test | Runs tests in tmux pane |
| mfussenegger/nvim-dap | `lua/kickstart/plugins/debug.lua` | Debug adapter protocol |
| rcarriga/nvim-dap-ui | dependency of nvim-dap | Debug UI |
| leoluz/nvim-dap-go | dependency of nvim-dap | Go debugger (delve) |

### Formatting & Linting
| Plugin | Location | Notes |
|--------|----------|-------|
| stevearc/conform.nvim | `init.lua:749` | Formatter (stylua for Lua, format on save) |
| mfussenegger/nvim-lint | `lua/kickstart/plugins/lint.lua` | Linter (markdownlint for .md) |
| windwp/nvim-autopairs | `lua/kickstart/plugins/autopairs.lua` | Auto-close brackets/quotes |

### UI
| Plugin | Location | Notes |
|--------|----------|-------|
| folke/which-key.nvim | `init.lua:311` | Keymap hints on `<Space>` |
| folke/todo-comments.nvim | `init.lua:911` | Highlights TODO/FIXME/etc |
| lukas-reineke/indent-blankline.nvim | `lua/kickstart/plugins/indent_line.lua` | Indent guides |
| nvim-tree/nvim-web-devicons | various dependencies | File icons (requires Nerd Font) |

## Key Options Set in init.lua

```lua
vim.g.mapleader = ' '          -- Space as leader
vim.g.have_nerd_font = true    -- Enables icon support throughout
vim.o.number = true            -- Line numbers
vim.o.relativenumber = true    -- Relative line numbers
vim.o.clipboard = 'unnamedplus' -- System clipboard sync
vim.o.undofile = true          -- Persistent undo
vim.o.autoread = true          -- Auto-reload files changed externally
vim.o.confirm = true           -- Prompt to save instead of error on :q
vim.o.scrolloff = 10           -- Keep 10 lines above/below cursor
vim.o.splitright = true        -- Vertical splits open to the right
vim.o.splitbelow = true        -- Horizontal splits open below
vim.o.timeoutlen = 300         -- Fast which-key popup
vim.o.updatetime = 250         -- Fast CursorHold (affects LSP highlight)
```

## Keymaps Reference

### Leader: `<Space>`

| Keymap | Action |
|--------|--------|
| `<leader>f` | Format buffer (conform.nvim) |
| `<leader>q` | Open diagnostic quickfix list |
| `<leader>/` | Fuzzy search current buffer |
| `<leader><leader>` | Find open buffers (telescope) |

### Search (`<leader>s`)
| Keymap | Action |
|--------|--------|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>sw` | Search current word |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>sn` | Search nvim config files |
| `<leader>s/` | Grep in open files |
| `<leader>ss` | Select telescope picker |

### LSP (buffer-local, active when LSP attached)
| Keymap | Action |
|--------|--------|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | Go to references |
| `grd` | Go to definition |
| `grD` | Go to declaration |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |

### Git (`<leader>h`)
| Keymap | Action |
|--------|--------|
| `]c` / `[c` | Next/prev git hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff against index |
| `<leader>hD` | Diff against last commit |
| `<leader>tb` | Toggle blame line |
| `<leader>tD` | Toggle show deleted |

### Testing (`vim-test` + vimux)
| Keymap | Action |
|--------|--------|
| `<leader>t` | TestNearest |
| `<leader>T` | TestFile |
| `<leader>a` | TestSuite |
| `<leader>l` | TestLast |
| `<leader>g` | TestVisit |

### Debugging (nvim-dap)
| Keymap | Action |
|--------|--------|
| `<F5>` | Start/Continue debug |
| `<F1>` | Step into |
| `<F2>` | Step over |
| `<F3>` | Step out |
| `<F7>` | Toggle DAP UI |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Set conditional breakpoint |

### AI (ThePrimeagen/99)
| Keymap | Mode | Action |
|--------|------|--------|
| `<leader>9s` | Normal | AI search project → quickfix |
| `<leader>9v` | Visual | AI edit visual selection |
| `<leader>9x` | Normal | Stop all AI requests |

### Navigation
| Keymap | Action |
|--------|--------|
| `<C-h/j/k/l>` | Move between nvim splits AND tmux panes |
| `\` | Toggle Neo-tree file explorer |
| `<Esc>` | Clear search highlights |
| `<Esc><Esc>` | Exit terminal mode |

### Surrounds (mini.surround)
| Keymap | Action |
|--------|--------|
| `sa` | Add surrounding |
| `sd` | Delete surrounding |
| `sr` | Replace surrounding |
| `sf` / `sF` | Find surrounding right/left |

## Autocommands

| Name | Events | Effect |
|------|--------|--------|
| `kickstart-highlight-yank` | TextYankPost | Flash highlight on yank |
| `kickstart-reload-changed` | TextChanged, BufEnter, WinEnter, FocusGained | Auto-reload files changed externally (for opencode integration) |
| `kickstart-lsp-attach` | LspAttach | Sets up all LSP keymaps per buffer |
| `kickstart-lsp-highlight` | CursorHold/CursorMoved | Highlights symbol references under cursor |

## LSP Servers

Managed by mason. Currently configured:
- `lua_ls` — Lua language server (with Neovim API awareness via lazydev)

To add more LSP servers, edit the `servers` table in `init.lua:683`:
```lua
local servers = {
  lua_ls = { ... },
  -- gopls = {},
  -- pyright = {},
  -- ts_ls = {},
}
```

Mason will auto-install them on next Neovim start.

## Formatting

- **Engine**: conform.nvim (format on save, 500ms timeout)
- **Lua**: stylua (auto-installed via mason-tool-installer)
- **C/C++**: format on save disabled
- **Manual format**: `<leader>f`

To add a formatter for a new language:
```lua
-- In init.lua, opts.formatters_by_ft table (~line 779):
formatters_by_ft = {
  lua = { 'stylua' },
  python = { 'black' },  -- add here
},
```

## The 99 Plugin (AI Integration)

Configured in `lua/custom/plugins/init.lua`.

- **Provider**: OpenCode (opencode CLI)
- **Model**: `opencode/minimax-m2.5-free`
- **Permissions**: Edit permissions auto-allowed via env var
- **tmp_dir**: `./tmp` (relative to project cwd)
- **md_files**: Looks for `AGENT.md` up the directory tree and injects it
- **custom_rules**: `scratch/custom_rules/` — type `#` in 99 prompt to autocomplete skills
- **completion source**: native (built-in)

## Rules for Modifying This Config

1. **Never edit `lazy-lock.json` manually** — it's managed by `:Lazy`
2. **New plugins go in `lua/custom/plugins/init.lua`** only
3. **After any plugin change**, restart Neovim (lazy.nvim cannot be re-sourced)
4. **Formatting**: this config uses 2-space indentation (see `.stylua.toml`)
5. **Test changes** with `:checkhealth` after significant modifications
6. **The `scratch/` directory** is for local/temporary files, not committed content
