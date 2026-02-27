# dotfiles

Personal dotfiles managed by chezmoi.

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/j-yang/dotfiles/main/install.sh | bash
```

## Post-Install

1. Restart shell: `source ~/.zshrc`
2. TPM: `Prefix + I` in tmux to install plugins
3. Neovim: Open nvim to install plugins
4. Git: `git config --global user.name "Your Name"`

## Tools

- **chezmoi**: dotfiles management
- **mise**: runtime version management
- **LazyVim**: Neovim distribution
- **tmux**: terminal multiplexer

## Structure

```
dot_config/
├── nvim/          # LazyVim config
├── tmux/          # tmux config (oh-my-tmux)
├── mise/          # mise config
├── ghostty/       # ghostty terminal
├── starship.toml  # prompt
└── ...
```