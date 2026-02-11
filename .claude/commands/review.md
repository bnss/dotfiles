# Comprehensive Code Review

Run 5 parallel review agents to catch regressions and issues from multiple angles.

## Instructions

First, identify the files that have changed (use git diff against main if on a feature branch, or look at recent commits).

Then launch these 5 review agents **in parallel** using the Task tool:

### 1. CLAUDE.md Compliance Review
Check if the changes follow the project's CLAUDE.md guidelines. Look for:
- Naming conventions violations
- Import ordering issues
- Missing type annotations
- Code style deviations
- Any rules specified in CLAUDE.md that aren't being followed

### 2. Shallow Bug Scan
Quick scan for obvious bugs and issues:
- Null/undefined access without checks
- Missing error handling
- Race conditions
- Memory leaks (unclosed resources, missing cleanup)
- Off-by-one errors
- Hardcoded values that should be configurable

### 3. Git Blame/History Review
Analyze the git history of modified files:
- Why were previous changes made?
- Are we reverting intentional fixes?
- Is there context from past commits we should know?
- Are we touching code that was recently fixed for a bug?

### 4. Past PR Comments Review
If this is a PR or feature branch, check for patterns from past PR feedback:
- Use `gh pr list --state merged --limit 10` to find recent PRs
- Look at comments on those PRs for recurring feedback themes
- Check if current changes repeat past mistakes
- Learn from what reviewers typically catch

### 5. Code Comments Compliance
Review inline comments and documentation:
- Are complex sections explained?
- Are TODOs addressed or properly tracked?
- Do JSDoc comments match the actual function signatures?
- Are deprecated patterns being introduced?

## Output Format

After all agents complete, provide a unified summary:
1. **Critical Issues** - Must fix before merge
2. **Warnings** - Should consider fixing
3. **Suggestions** - Nice to have improvements
4. **Compliance Score** - Overall assessment

$ARGUMENTS - Optional: specific files or PR number to review
