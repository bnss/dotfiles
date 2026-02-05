#!/bin/bash

# Remove 🔴 prefix from tmux window name if present
current=$(tmux display-message -p '#W' 2>/dev/null)
if [[ "$current" == 🔴* ]]; then
  tmux rename-window "${current#🔴 }"
fi
