#!/bin/bash
# Setup script for new rx-frontend worktrees
# Usage: ../setup-worktree.sh (run from inside the worktree)

REFERENCE_REPO="$HOME/Code/rx-frontend"
WORKTREE_DIR="$(pwd)"
SKIP_INSTALL=false
[[ "$1" == "--skip-install" ]] && SKIP_INSTALL=true

echo "Setting up worktree: $WORKTREE_DIR"

# Symlink env files
ln -sf "$REFERENCE_REPO/.env.local" "$WORKTREE_DIR/.env.local"
ln -sf "$REFERENCE_REPO/.env.e2e" "$WORKTREE_DIR/.env.e2e"

# Symlink vscode settings
mkdir -p "$WORKTREE_DIR/.vscode"
ln -sf "$REFERENCE_REPO/.vscode/settings.json" "$WORKTREE_DIR/.vscode/settings.json"

echo "✓ Symlinks created:"
ls -la "$WORKTREE_DIR/.env.local" "$WORKTREE_DIR/.env.e2e" "$WORKTREE_DIR/.vscode/settings.json"

if $SKIP_INSTALL; then
  echo ""
  echo "✓ Worktree setup complete (npm install deferred to tmux pane)"
else
  # Install dependencies
  echo ""
  echo "Installing dependencies..."
  npm install

  echo ""
  echo "✓ Worktree setup complete!"
fi
