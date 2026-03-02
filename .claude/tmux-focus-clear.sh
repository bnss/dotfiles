#!/bin/bash

# Called by tmux after-select-window/after-select-pane hooks to clear 🔴
# when switching to a Claude window. Only acts when the active pane actually
# changes — ignores re-selection of the same pane (e.g. mouse clicks).

pane_id=$(tmux display-message -p '#{pane_id}' 2>/dev/null)
last_pane=$(tmux show-option -gqv @claude-last-pane 2>/dev/null)
# echo "$(date): FOCUS-CLEAR - pane_id=$pane_id last_pane=$last_pane window=$(tmux display-message -p '#I:#W')" >> /tmp/claude-tmux.log

if [[ "$pane_id" != "$last_pane" ]]; then
  tmux set-option -g @claude-last-pane "$pane_id"

  current=$(tmux display-message -p '#W' 2>/dev/null)
  if [[ "$current" == 🔴* ]]; then
    tmux rename-window "${current#🔴 }"
  fi
fi
