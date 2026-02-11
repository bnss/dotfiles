#!/bin/bash

# Debug logging (comment out when working)
# echo "$(date): CLEAR - pane=$TMUX_PANE window=$(tmux display-message -p '#I:#W')" >> /tmp/claude-tmux.log

# Bail early if not in tmux
[ -z "$TMUX" ] && exit 0

# Get current window name
current=$(tmux display-message -p '#W' 2>/dev/null)

# Remove 🔴 prefix if present
if [[ "$current" == 🔴* ]]; then
  tmux rename-window "${current#🔴 }"
fi
