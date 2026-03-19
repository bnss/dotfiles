---
name: babysit-pr
description: Check PR for review comments, fix actionable ones, commit and push. Designed for use with /loop.
---

# Babysit PR

Monitor the current branch's PR for unresolved review comments. For each comment: assess it, fix code if needed, reply, resolve the thread, then commit and push. Designed to be called repeatedly via `/loop 5m /babysit-pr` until all comments are addressed.

## Input

No arguments required. Operates on the current branch's open PR.

## Steps to Execute

### Step 1: Find the PR

```bash
gh pr view --json number,url,state,headRepository
```

- If no PR exists for this branch, print "No open PR for this branch" and **stop**.
- If PR state is not `OPEN`, print "PR is not open (state: ...)" and **stop**.
- Extract the `number`, repo `owner`, and repo `name` for subsequent API calls.

### Step 2: Fetch unresolved review threads

Use GraphQL to get review threads with their resolution status:

```bash
gh api graphql -f query='
  query($owner:String!, $repo:String!, $number:Int!) {
    repository(owner:$owner, name:$repo) {
      pullRequest(number:$number) {
        reviewThreads(first:50) {
          nodes {
            id
            isResolved
            isOutdated
            comments(first:10) {
              nodes {
                id
                databaseId
                body
                author { login }
                path
                line
                originalLine
              }
            }
          }
        }
      }
    }
  }
' -f owner="<owner>" -f repo="<repo>" -F number=<number>
```

Filter to threads where:
- `isResolved` is `false`
- `isOutdated` is `false`

Skip threads where the only commenter is the PR author (self-comments).

### Step 3: Check if there's work to do

If no unresolved threads remain, print:

```
No unresolved review comments on PR #<number>
```

And **stop**. This makes the skill idempotent for `/loop` usage.

### Step 4: Process each unresolved thread

For each unresolved thread:

1. **Read the comment** — get the first comment's `body`, `path`, `line`, and `author.login`
2. **Read the code** — use the Read tool to read the referenced file around the mentioned line
3. **Assess the comment** — determine if it's:
   - **Actionable**: suggests a concrete code change, points out a bug, or recommends a refactor
   - **Non-actionable**: question, praise, informational note, or style preference that doesn't warrant a change
4. **If actionable**:
   - Apply the fix using the Edit tool
   - Compose a reply explaining what was changed
5. **If non-actionable**:
   - Compose a reply acknowledging the comment (e.g., "Noted, thanks!" or answer the question)
6. **Reply to the comment** (REST API):
   ```bash
   gh api repos/<owner>/<repo>/pulls/<number>/comments/<databaseId>/replies -f body="<reply>"
   ```
7. **Resolve the thread** (GraphQL mutation — use inline ID, not variables, as `gh api graphql -f` mangles `$` in variable mode):
   ```bash
   gh api graphql -f query='mutation { resolveReviewThread(input:{threadId:"<thread.id>"}) { thread { isResolved } } }'
   ```

### Step 5: Pre-commit checks

After all fixes are applied, run:

```bash
npx tsc --noEmit && npm run lint
```

If either fails, fix the issues before proceeding.

### Step 6: Commit, push, and re-request review

Only if code changes were made:

```bash
git add <specific-changed-files>
git commit -m "fix: address PR review feedback"
git push
```

After every push (whether code changes or just replies), re-request Copilot review via the REST API (`--add-reviewer` silently no-ops if already a reviewer):

```bash
gh api repos/<owner>/<repo>/pulls/<number>/requested_reviewers -f 'reviewers[]=copilot-pull-request-reviewer[bot]' --method POST
```

**Important:**
- NO Claude signature (no `Co-Authored-By`)
- Stage specific files, not `git add -A`
- If no code changes were made (only replies/resolves), skip the commit but still re-request review after resolving threads
- Always re-request copilot review after push so new comments arrive for the next loop iteration

### Step 7: Summary

Print a summary of what was done:

```
PR #<number> review summary:
- <file>:<line> — <abbreviated comment> → Fixed: <what was changed>
- <file>:<line> — <abbreviated comment> → Replied: <response>
```

## Notes

- This skill is designed to run autonomously without user interaction
- All required permissions (git, gh, Edit, Read) are pre-allowed in settings.json
- The skill is safe to run repeatedly — it only processes unresolved threads
- Commit messages don't need a Jira ticket — the PR title already contains it
