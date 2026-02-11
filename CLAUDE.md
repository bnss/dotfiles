# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository for macOS development environment. Config files here are symlinked to their target locations via `init.sh`.

## Structure

| Directory/File | Purpose | Symlinked To |
|---------------|---------|--------------|
| `zshrc` | Zsh configuration | `~/.zshrc` |
| `aliases` | Shell aliases and functions | `~/.aliases` |
| `nvim/` | Neovim config (Lua-based, uses lazy.nvim) | `~/.config/nvim/` |
| `tmux/tmux.conf` | Tmux configuration | `~/.tmux.conf` |
| `ghostty/config` | Ghostty terminal config | `~/.config/ghostty/config` |
| `.claude/` | Claude Code settings | `~/.claude/` |
| `karabiner/` | Keyboard remapping | `~/.config/karabiner/` |
| `starship.toml` | Starship prompt config | `~/.config/starship.toml` |

## Key Patterns

**Symlink convention**: All configs live here and are symlinked to their target locations. When adding new configs:
1. Store the file in this repo
2. Add symlink command to `init.sh`
3. Never put secrets here - those go in local-only files

**Theming**: Uses `tinted-theming/tinty` for coordinated colors across terminal, tmux, and vim. Apply themes with `tinty apply <theme-name>`.

**Neovim**: Lua-based config with lazy.nvim plugin manager. Leader key is `,`.
- `nvim/init.lua` - Entry point, loads modules
- `nvim/lua/general.lua` - Core vim settings
- `nvim/lua/mappings.lua` - Keybindings
- `nvim/lua/plugins/init.lua` - Plugin definitions

**Worktree helpers**: The `aliases` file contains functions (`wta`, `wtc`, `awtc`, `feature`) for git worktree workflows used in other repos.

## Setup

Fresh machine setup:
```bash
./init.sh
```

This will:
1. Install Homebrew packages (ghostty, tmux, nvim, fzf, etc.)
2. Create necessary directories
3. Symlink all config files
4. Install tmux plugins via tpm
5. Set up theming with tinty
