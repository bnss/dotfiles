#!/bin/bash

# Debug logging (comment out when working)
# echo "$(date): NOTIFY - pane=$TMUX_PANE active=$(tmux display-message -p '#{pane_id}') window=$(tmux display-message -p '#I:#W')" >> /tmp/claude-tmux.log

# Bail early if not in tmux
[ -z "$TMUX" ] && exit 0

# Only set 🔴 if the user is NOT looking at this pane
active_pane=$(tmux display-message -p '#{pane_id}' 2>/dev/null)
[[ "$TMUX_PANE" == "$active_pane" ]] && exit 0

# Get window name for this Claude pane (not the active window)
current=$(tmux display-message -t "$TMUX_PANE" -p '#W' 2>/dev/null)

# Add 🔴 prefix if not already present
if [[ -n "$current" && "$current" != 🔴* ]]; then
  # Disable automatic-rename to prevent tmux from overwriting our custom name
  tmux set-window-option -t "$TMUX_PANE" automatic-rename off 2>/dev/null
  tmux rename-window -t "$TMUX_PANE" "🔴 $current"
fi
