## PRIORITY #0: Read and Follow This File

**ALWAYS read CLAUDE.md at the start of every session.** These are not suggestions - they are rules. When this file says "don't do X", that means NEVER do X. Examples:
- "No Claude signature in commit messages" → Don't add `Co-Authored-By: Claude` or similar
- "Be terse in PR descriptions" → Don't add marketing fluff like "🤖 Generated with Claude Code"
- If I correct you, it means you missed something here - re-read and internalize it

---

## PRIORITY #1: Privacy Boundaries

**NEVER access, read, or attempt to access:**
- Keychain / password managers
- Private keys, tokens, credentials
- Personal folders (Photos, Documents, Desktop, Downloads, Mail, Messages)
- Browser data, cookies, history
- Any personal/sensitive data

If searching for something and can't find it in config files, **stop and ask** - don't go hunting through personal locations.

---

## Repository Locations

| Alias | Path | Description |
|-------|------|-------------|
| hb-ui-kit | `~/Code/ap-ui/packages/hb-ui-kit` | Hummingbird UI Kit (design system components) |
| ap-ui | `~/Code/ap-ui` | AP-UI monorepo (all UI packages) |
| frontend | `~/Code/rx-frontend-wt/main` | RX Frontend (main application worktree) |
| backend | `~/Code/rx-api` | RX Backend |
| backend | `~/Code/rx-analytics` | RX Backend |
| flipt | `~/Code/rx-flipt-feature-flags` | Feature flags (Flipt) - prod & stage configs |

## Feature Flags

**ALWAYS read the lifecycle docs before making feature flag changes:**
[Ways of working with feature flags](https://accelins.atlassian.net/wiki/spaces/PT1/pages/2471428433/Ways+of+working+with+feature+flags#Feature-flags-lifecycle-and-configuration-examples)

Key stages:
- **Development**: `enabled: false` with team/QA rollouts
- **Acceptance testing**: Stage `enabled: true` (except `stage-prodlike-qa-segment`), Prod `enabled: false` with QA rollouts
- **Release**: Both stage and prod `enabled: true`, clean up rollout segments
- **Cleanup**: Remove flag from code and config

## Config Structure
- `~/.claude/CLAUDE.md` → symlinked to `~/dotfiles/.claude/CLAUDE.md` (backed up)
- `~/.claude/settings.json` → symlinked to `~/dotfiles/.claude/settings.json` (backed up)
- `~/.claude/settings.secrets.json` → local only, NOT backed up (for API keys, tokens)

## Self-Improvement
- After any correction from me, ask: "Should I update CLAUDE.md so I don't make this mistake again?"
- When I say yes, add a concise rule to prevent the specific mistake
- When creating personal config files, ALWAYS store them in `~/dotfiles/` and symlink to their target location. Update `~/dotfiles/init.sh` with the symlink command. NEVER include secrets (API keys, tokens) in dotfiles - those go in local-only files like `settings.secrets.json`.

## Verification & Quality
- After completing a feature, offer: "Want me to verify this works with a background agent?"
- For long-running tasks, use subagents to verify work
- Run tests after making changes to catch regressions
- Use "code-simplifier" subagent after completing features to clean up code

## Prompting Patterns I May Use
- "Grill me on these changes" = Review my code critically before PR
- "Prove to me this works" = Diff behavior between main and feature branch
- "Use subagents" = Throw more compute at the problem
- "Scrap this and implement the elegant solution" = Start fresh with learnings

## Git

### Golden Rules
- **Never commit directly to main** - always use feature branches
- **Always pull main before**: creating branches, comparing/diffing, reviewing PRs
  - In worktree setups: `git -C <path-to-main-worktree> pull`
- Read-only git commands can be executed without asking (`git log`, `git diff`, `git blame`, `git status`, `git branch`, `git show`)

### Branch Naming
- Format: `ben/<type>/[optional-jira-ticket]<description>`
- Types: `feat`, `fix`, `chore`, `refactor`, `docs`, `test`
- Examples: `ben/feat/AC-12345-add-export`, `ben/fix/null-pointer-error`

### Commit Messages
- Format: `<type>: AC-XXXXX description here`
- Always include Jira ticket (ask if none exists)
- No Claude signature in commit messages

### Pre-Commit Checks
**ALWAYS run before committing** (in the worktree directory):
```bash
npx tsc --noEmit && npm run lint
```
If either fails, fix issues before committing. Don't skip this step.

### Worktree Workflow
- Structure: `repo-wt/` (bare) with `main/`, `feature-a/`, `feature-b/` as worktrees
- Each worktree can run its own Claude session independently
- Use `/worktree` skill for guided setup, or follow checklist below

### Worktree Setup Checklist
When creating a new worktree, **always complete ALL steps**:
1. Pull main first: `git -C <main-worktree> pull`
2. Create worktree: `git worktree add ../<name> -b <branch> main`
3. Copy env symlinks:
   ```bash
   ln -s /Users/bnss/Code/rx-frontend/.env.local <new-worktree>/.env.local
   ln -s /Users/bnss/Code/rx-frontend/.env.e2e <new-worktree>/.env.e2e
   ```
4. Install dependencies: `cd <new-worktree> && npm install`
5. Verify auth works: test Jira/GitHub connection before proceeding

**NEVER skip steps 3-5** - missing env files cause auth failures downstream.

## Commandline & Permissions
- `~/.claude/settings.json` defines auto-allowed commands - never ask permission for those
- When asking permission for a read-only or repetitive command, suggest: "Want me to add this to settings.json?"

## GitHub
- Favor `gh` CLI over MCP tools for GitHub operations
- For Actions workflow runs/job logs: always use `gh` CLI (`gh run view`, `gh run view --job`), never WebFetch
- When creating PRs, assign `bnss` as assignee
- Add copilot as reviewer: try `--reviewer copilot` during `gh pr create`, if it fails use `gh pr edit <number> --add-reviewer copilot`

## Jira Defaults

**If Jira MCP returns 401/auth error**: ALWAYS notify user to re-authenticate (`/mcp`), never proceed without a ticket.

### Commit Workflow (IMPORTANT - Follow this order):
1. **BEFORE committing**: Check if a Jira ticket exists for this work
2. **If NO ticket exists**: Ask user if one should be created
3. **If user says YES**: Create the Jira ticket FIRST, then commit with ticket number
4. **If user says NO**: Commit without ticket number, add `pre-approved` label to PR later

### Pull Request Format:
- PR titles must match commit format: `fix: AC-55216 description here`
- Be terse in PR descriptions
- If no ticket exists, add `pre-approved` label to PR (not in title)

When creating Jira tickets, use these defaults:

- Cloud ID: `d2499717-7d5b-4853-8d05-3cd88d45e753`
- Team: External Analytics (`c7e941f9-6983-47a0-bdaf-0aa50e9af528`)
- Project: `AC`
- Sprint: External Analytics active sprint (fetch it)
- Assignee: Ben Schepmans (`712020:ebbc8b7f-5fe8-4f29-9cd6-711330adeddb`)
- Issue Type: `Task`
- Status: `In progress`

## Sentry Defaults

- When you mark a sentry issue as resolved, please mark it as "resolved in the next release"

## Claude Code Sessions

- Proactively offer to rename the session when:
  - The purpose of the session becomes clear (after initial exploratory chat)
  - The context shifts significantly from the original topic
- Ask: "Want to rename this session to `<suggested-name>`?" with a short, descriptive name
- Use `/rename <session-name>` to rename

## Response Formatting

- Visually clear but **compact** - don't add excessive blank lines or padding
- Use **bold** for key terms, `code` for commands/paths
- Bullet points over paragraphs when listing things
- One blank line between sections max
