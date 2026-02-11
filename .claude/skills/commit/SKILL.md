---
name: commit
description: Full commit workflow - creates branch if needed, creates Jira ticket if needed, commits changes, and creates PR
---

# Commit Workflow

This skill automates the full commit workflow:
1. Creates a new branch (if not already on a feature branch)
2. Creates a Jira ticket (if not provided)
3. Commits changes (without Claude signature)
4. Creates a PR

## Input

Optional argument: Jira ticket number (e.g., `AC-12345`) or description if no ticket exists yet.

## Steps to Execute

### Step 1: Check current branch status

```bash
git branch --show-current
git status
```

Determine if:
- Already on a feature branch (starts with `ben/`) - skip branch creation
- On `main` - need to create a new branch

### Step 2: Analyze changes

```bash
git diff --staged
git diff
git log --oneline -5
```

Understand:
- What files are changed
- The nature of the changes (fix, feat, chore, refactor, docs, test)
- Recent commit message style for consistency

### Step 3: Create Jira ticket (if needed)

**If no ticket number was provided in the argument:**

Ask the user: "Should I create a Jira ticket for this work?"

If yes, create the ticket using the Atlassian MCP tools with these defaults:
- Cloud ID: `d2499717-7d5b-4853-8d05-3cd88d45e753`
- Project: `AC`
- Team: External Analytics (`c7e941f9-6983-47a0-bdaf-0aa50e9af528`)
- Sprint: Fetch active sprint for External Analytics
- Assignee: Ben Schepmans (`712020:ebbc8b7f-5fe8-4f29-9cd6-711330adeddb`)
- Issue Type: `Task`
- Status: Set to `In progress` after creation

If no, proceed without a ticket (will add `pre-approved` label to PR later).

### Step 4: Create branch (if needed)

If on `main`, create a feature branch:

```bash
git checkout -b ben/<type>/<ticket>-<description>
```

Where:
- `<type>` is `feat`, `fix`, `chore`, `refactor`, `docs`, or `test`
- `<ticket>` is the Jira ticket (e.g., `AC-12345`) - omit if none
- `<description>` is kebab-case summary (e.g., `remove-backend-visible-dependency`)

### Step 5: Stage and commit

Stage relevant files (be specific, avoid `git add -A`):

```bash
git add <specific-files>
```

Commit with the proper format:

```bash
git commit -m "<type>: AC-XXXXX description here"
```

**Important:**
- NO Claude signature (no `Co-Authored-By`)
- Commit message format: `<type>: AC-XXXXX description`
- If no ticket, omit the ticket number: `<type>: description`

### Step 6: Push and create PR

```bash
git push -u origin <branch-name>
```

Create the PR:

```bash
gh pr create --title "<type>: AC-XXXXX description" --body "$(cat <<'EOF'
## Summary
<1-3 bullet points describing the changes>

## Test plan
<How to verify the changes work>
EOF
)" --assignee bnss
```

Then add copilot as reviewer:

```bash
gh pr edit <PR_NUMBER> --add-reviewer copilot
```

**If no Jira ticket exists**, add the `pre-approved` label:

```bash
gh pr edit <PR_NUMBER> --add-label pre-approved
```

### Step 7: Return the PR URL

Provide the user with the PR URL so they can review it.

## Conventions Reference

From CLAUDE.md:
- Branch format: `ben/<type>/[optional-jira-ticket]<description>`
- Commit format: `<type>: AC-XXXXX description here`
- Types: `feat`, `fix`, `chore`, `refactor`, `docs`, `test`
- No Claude signature in commits
- PR assignee: `bnss`
- Add copilot as reviewer
- If no ticket: add `pre-approved` label to PR
