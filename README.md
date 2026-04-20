# Dotfiles

## Setup

```bash
# Clone repo
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# Link configs
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Install TPM (tmux plugins)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Open nvim to install plugins
nvim
```

## Requirements

- macOS: `brew install tmux neovim git ripgrep fd fzf`
- Ubuntu: `sudo apt install tmux neovim git ripgrep fd-find fzf`

## Post-Setup

- Start tmux: `tmux`
- Install tmux plugins: `Prefix + I` (Prefix is `Ctrl-s`)
- Reload tmux config: `Prefix + r`

## Claude Code

```bash
npm install -g @anthropic-ai/claude-code
```
