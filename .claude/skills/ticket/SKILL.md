# /ticket - Full Feature Setup

Creates a complete feature workflow: Jira ticket + worktree + environment.

## Usage
```
/ticket <description>
```

## Workflow

### 1. Create Jira Ticket
- Use defaults from CLAUDE.md (team, project, sprint, assignee)
- Set status to "In progress"
- Return ticket number (e.g., AC-12345)

### 2. Determine Repository
Ask user which repo if not obvious from context:
- `rx-frontend-wt` - RX Frontend
- `ap-ui-wt` - AP-UI

### 3. Create Worktree
```bash
# Pull main first
git -C <repo>/main pull

# Create worktree with branch
git -C <repo>/main worktree add ../<ticket-number> -b ben/feat/<ticket-number>-<slug> main
```

### 4. Setup Environment
```bash
# Symlink env files (rx-frontend only)
ln -s /Users/bnss/Code/rx-frontend/.env.local <worktree>/.env.local
ln -s /Users/bnss/Code/rx-frontend/.env.e2e <worktree>/.env.e2e

# Install dependencies
cd <worktree> && npm install
```

### 5. Setup Tmux Window (optional)
If user wants, create a new tmux window for the worktree:
```bash
tmux new-window -n <ticket-number> -c <worktree>
```

### 6. Verify
- Confirm worktree exists: `git worktree list`
- Confirm env files are linked
- Run quick build check: `npm run build` or `npx tsc --noEmit`

## Output
Report:
- Jira ticket URL
- Worktree path
- Branch name
- Any setup issues encountered

## Error Handling
- If Jira auth fails: Stop and ask user to re-authenticate (`/mcp`)
- If worktree creation fails: Check if branch already exists
- If npm install fails: Report error, don't proceed
