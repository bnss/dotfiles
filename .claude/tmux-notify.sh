#!/bin/bash

# Debug logging (comment out when working)
# echo "$(date): NOTIFY - pane=$TMUX_PANE window=$(tmux display-message -p '#I:#W')" >> /tmp/claude-tmux.log

# Bail early if not in tmux
[ -z "$TMUX" ] && exit 0

# Get current window name, explicitly targeting the pane's window
current=$(tmux display-message -p '#W' 2>/dev/null)

# Add 🔴 prefix if not already present
if [[ -n "$current" && "$current" != 🔴* ]]; then
  # Disable automatic-rename to prevent tmux from overwriting our custom name
  tmux set-window-option automatic-rename off 2>/dev/null
  tmux rename-window "🔴 $current"
fi
