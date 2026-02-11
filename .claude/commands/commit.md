# Commit Changes

Create a git commit for staged/unstaged changes.

## Pre-Commit Review Reminder

**Before committing**, consider whether you've run `/review` on these changes.

If you haven't reviewed the changes yet, ask the user:
> "Would you like me to run `/review` first to check for regressions and issues before committing?"

If the user says yes, run the review first. If they decline or have already reviewed, proceed with the commit.

## Commit Workflow

Follow the standard git commit workflow from CLAUDE.md:

1. **Run lint/format checks FIRST** (required - CI/CD will fail without this):
   ```bash
   npx tsc --noEmit && npm run lint
   ```
   If either fails, fix the issues before proceeding. Do NOT skip this step.

2. Run these commands in parallel:
   - `git status` to see all untracked files (never use -uall flag)
   - `git diff` to see both staged and unstaged changes
   - `git log --oneline -10` to see recent commit message style

4. Analyze all staged changes and draft a commit message:
   - Summarize the nature of changes (feature, fix, refactor, etc.)
   - Keep it concise (1-2 sentences) focusing on "why" not "what"
   - Use format: `<type>: AC-XXXXX description here`
   - If no Jira ticket exists, ask user if one should be created

5. Stage relevant files and create the commit:
   - Add specific files (avoid `git add -A`)
   - Don't commit files with secrets (.env, credentials, etc.)
   - Use HEREDOC for commit message formatting

6. Verify with `git status` after commit

## Commit Message Format

```
<type>(<scope>): AC-XXXXX description

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

Types: `feat`, `fix`, `chore`, `refactor`, `docs`, `test`

$ARGUMENTS - Optional: specific commit message or files to include
