# Dotfiles

## Setup

```bash
# Clone repo
git clone https://github.com/Javacadu/dotfiles.git ~/dotfiles

# Link configs
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.config/tmux ~/.config/tmux
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Install TPM (tmux plugins)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Start tmux and install plugins (Prefix + I, Prefix is Ctrl-s)
tmux

# Open nvim to install plugins
nvim
```

## Requirements

- macOS: `brew install tmux neovim git ripgrep fd fzf tmuxp`
- Ubuntu: `sudo apt install tmux neovim git ripgrep fd-find fzf tmuxp`
- Arch Linux: `sudo pacman -S tmux neovim git ripgrep fd fzf tmuxp`

## Post-Setup

- Start tmux: `tmux`
- Install tmux plugins: `Prefix + I` (Prefix is `Ctrl-s`)
- Reload tmux config: `Prefix + r`
- Start dev session: `tmuxp load dev`

## opencode

```bash
# Link the council config (agents, commands, skills, prompt library)
ln -sfn ~/dotfiles/opencode ~/.config/opencode
```

Install opencode from https://opencode.ai or `curl -fsSL https://opencode.ai/install | bash`.
See `opencode/INSTALL.md` for full setup, per-machine changes, and how to keep the folder in sync.
