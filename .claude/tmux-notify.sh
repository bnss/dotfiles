#!/bin/bash

# Add 🔴 prefix to tmux window name if not already present
current=$(tmux display-message -p '#W' 2>/dev/null)
if [[ -n "$current" && "$current" != 🔴* ]]; then
  tmux rename-window "🔴 $current"
fi
