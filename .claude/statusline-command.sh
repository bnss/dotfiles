#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract current directory (shortened)
cwd=$(echo "$input" | jq -r '.workspace.current_dir' | sed "s|$HOME|~|")

# Extract model display name
model=$(echo "$input" | jq -r '.model.display_name')

# Get git branch if in a git repo
full_cwd=$(echo "$input" | jq -r '.workspace.current_dir')
if cd "$full_cwd" 2>/dev/null && git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
else
    branch=""
fi

# Calculate context usage
usage=$(echo "$input" | jq '.context_window.current_usage')
size=$(echo "$input" | jq '.context_window.context_window_size')

if [ "$usage" != "null" ] && [ "$size" != "null" ]; then
    current=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    current_k=$((current / 1000))
    size_k=$((size / 1000))
    pct=$((current * 100 / size))
    context_info="ctx: ${current_k}k/${size_k}k (${pct}%)"
else
    context_info=""
fi

# Build the status line
parts="${cwd}"
[ -n "$branch" ] && parts="${parts} | ${branch}"
parts="${parts} | ${model}"
[ -n "$context_info" ] && parts="${parts} | ${context_info}"
echo "$parts"
