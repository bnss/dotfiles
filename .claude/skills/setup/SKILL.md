# /setup - Environment Verification

Front-loads environment checks before starting work to catch blockers early.

## Usage
```
/setup
```

## Checks Performed

### 1. Environment Files
Check if required .env files exist:
```bash
ls -la .env.local .env.e2e 2>/dev/null
```
If missing in rx-frontend worktree, suggest:
```bash
ln -s /Users/bnss/Code/rx-frontend/.env.local .env.local
ln -s /Users/bnss/Code/rx-frontend/.env.e2e .env.e2e
```

### 2. Tool Authentication
Test that integrations work:
- **Jira**: Attempt a simple query (get current sprint)
- **GitHub**: Run `gh auth status`
- **Sentry**: Test with `mcp__Sentry__whoami` if available

Report any auth failures immediately - don't proceed with work that requires the tool.

### 3. Dependencies
```bash
# Check node_modules exists
ls node_modules/.bin 2>/dev/null | head -5

# If missing
npm install
```

### 4. Quick Type Check
```bash
npx tsc --noEmit 2>&1 | head -20
```
Report any existing type errors so they're not confused with new issues.

### 5. Git Status
```bash
git status --short
git log --oneline -3
```
Report current branch and any uncommitted changes.

## Output Format
```
Environment Check Results
========================
.env files: OK / MISSING (with fix command)
Jira auth: OK / FAILED (suggest /mcp)
GitHub auth: OK / FAILED
Dependencies: OK / MISSING
Type check: OK / X errors (list first few)
Git: branch-name, clean / X uncommitted files

Ready to proceed: YES / NO (with blockers listed)
```

## When to Use
- Starting work in a new worktree
- Before debugging a complex issue
- When things aren't working and you're not sure why
- After switching between repos
