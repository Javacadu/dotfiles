# Install: opencode

This folder is the global opencode configuration (`~/.config/opencode/`): the
agents (coder, research, plan), commands, skills, and the raw prompt
library. Copy it to any machine to reproduce the exact setup.

## Prerequisite

Install opencode itself (this folder is config only — opencode is installed
separately on each machine):

```bash
curl -fsSL https://opencode.ai/install | bash
```

See https://opencode.ai for alternatives (npm, brew, Windows).

## Install

Link the folder into place (same convention as nvim and tmux in this repo):

```bash
git clone https://github.com/Javacadu/dotfiles.git ~/dotfiles
ln -sfn ~/dotfiles/opencode ~/.config/opencode
```

No symlinks on your setup? Copy instead:

```bash
cp -R ~/dotfiles/opencode ~/.config/opencode
```

Then restart opencode — config is loaded once at startup.

## Per-machine changes

- `opencode.jsonc`: change `"username"` to your own name.
- The `provider.opencode.whitelist` lists models by account; they resolve on
  any machine signed into the same opencode account. Edit the list if you use
  a different account.
- Auth lives per-machine in `~/.local/share/opencode/auth.json` — never copy
  it between machines.

## Secrets

This config contains no API keys. If you add providers that need keys (e.g.
`provider.<name>.options.apiKey`), keep those in `~/.local/share/opencode/auth.json`
via `opencode auth` — never in this repo.

## Updating this folder on the source machine

The live config at `~/.config/opencode` is the working copy. After changing it
locally, mirror the change into this repo:

```bash
rsync -a --exclude node_modules --exclude package.json --exclude package-lock.json \
  --exclude bun.lock --exclude .DS_Store --exclude .gitignore \
  ~/.config/opencode/ ~/dotfiles/opencode/
```

Then commit and push.

## Verify

```bash
opencode
```

- Tab cycles primary agents: coder → research → plan.
- @-mention or `/research`, `/review`, `/verify` invoke the subagents.
- The plan agent runs shell commands without prompting, but `rm` is denied
  outright (`permission.bash` in `agent/plan.md`).
