---
name: babysit-pr-auto
description: Self-scheduling PR babysitter. Checks for review comments, fixes them, and re-schedules itself until all comments are resolved.
---

# Babysit PR (Auto)

Self-scheduling version of `/babysit-pr`. Checks for unresolved review comments, processes them, and schedules another run ~5 minutes later. When no comments remain, the chain stops automatically.

## Input

No arguments required. Operates on the current branch's open PR.

## Steps to Execute

### Step 1: Find the PR

```bash
gh pr view --json number,state
```

- If no PR or state is not `OPEN`, print status and **stop** (don't schedule next run).

### Step 2: Check for unresolved review threads

```bash
gh api graphql -f query='query { repository(owner:"accelins", name:"rx-frontend") { pullRequest(number:<NUMBER>) { author { login } reviewThreads(first:50) { nodes { id isResolved isOutdated comments(first:10) { nodes { databaseId body author { login } path line } } } } } } }'
```

Filter to threads where `isResolved: false`, `isOutdated: false`, and first comment author is not the PR author.

### Step 3: If no unresolved threads → STOP

Print:
```
All clear — no unresolved review comments on PR #<number>. Stopping.
```

**Do NOT schedule a next run.** The chain ends here.

### Step 4: Process each unresolved thread

For each thread (same as `/babysit-pr`):

1. Read the comment's `body`, `path`, `line`
2. Read the referenced file around that line
3. Assess: actionable (code fix) or non-actionable (question/FYI)?
4. If actionable: apply fix with Edit tool
5. If non-actionable: compose an acknowledgment reply
6. Reply via REST: `gh api repos/<owner>/<repo>/pulls/<number>/comments/<databaseId>/replies -f body="<reply>"`
7. Resolve via GraphQL: `gh api graphql -f query='mutation { resolveReviewThread(input:{threadId:"<thread.id>"}) { thread { isResolved } } }'`

### Step 5: Pre-commit checks

```bash
npx tsc --noEmit && npm run lint
```

Fix any issues.

### Step 6: Commit, push, and re-request review

Only if code changes were made:

```bash
git add <specific-changed-files>
git commit -m "fix: address PR review feedback"
git push
```

After every push, re-request Copilot review:

```bash
gh api repos/<owner>/<repo>/pulls/<number>/requested_reviewers -f 'reviewers[]=copilot-pull-request-reviewer[bot]' --method POST
```

**Important:**
- NO Claude signature
- Stage specific files, not `git add -A`
- Skip commit if no code changes (only replies/resolves)

### Step 7: Schedule next run

Since comments were found and processed, schedule a one-shot re-run to check for new comments after the reviewer has had time to respond.

Use `CronCreate` with:
- `cron`: calculate current time + 5 minutes, pin to that specific minute/hour. E.g., if it's 10:42, schedule for `47 10 * * *` (minute 47, hour 10).
- `prompt`: `/babysit-pr-auto`
- `recurring`: `false` (one-shot — the next run will schedule its own follow-up if needed)

Print:
```
Scheduled next check in ~5 minutes. Will auto-stop when no more comments.
```

### Step 8: Summary

```
PR #<number> review summary:
- <file>:<line> — <abbreviated comment> → Fixed/Replied: <what was done>
- Next check scheduled at HH:MM
```

## Notes

- Each run is a one-shot that decides whether to schedule the next
- The chain self-terminates when no unresolved comments remain
- No manual cancellation needed — just wait for "All clear"
- If the PR is closed/merged between runs, the next run detects it and stops
- All permissions (git, gh, npx, Edit, Read) are pre-allowed in settings.json
